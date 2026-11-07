# Models Rule

Apply these rules whenever creating or editing a Dart model that represents a database table.

## 1. Dependencies

- `freezed_annotation` and `json_annotation` in `dependencies`.
- `freezed`, `json_serializable`, and `build_runner` in `dev_dependencies`.
- Use Freezed 3.x syntax: every model is declared as `abstract class`.

## 2. File and naming conventions

- One model per file, file name in `snake_case` matching the class (`post.dart` -> `Post`).
- Class name is singular and PascalCase (table `posts` -> `Post`).
- Every file must include both parts:
  ```dart
  part 'post.freezed.dart';
  part 'post.g.dart';
  ```
- Never edit generated files (`*.freezed.dart`, `*.g.dart`). Never hand-write `copyWith`, `==`, or `hashCode`.

## 3. Model template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    @JsonKey(name: 'user_id') required int userId, // FK column
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
```

## 4. Column mapping

- Dart fields are `camelCase`; DB columns are `snake_case`.
- Map each differing column with `@JsonKey(name: 'column_name')`.
- Field types must match column types: `INTEGER` -> `int`, `TEXT` -> `String`, `REAL` -> `double`, timestamps -> `DateTime`.
- `NOT NULL` column -> `required` non-nullable field. Nullable column -> nullable type (`String?`).
- Use `@Default(value)` only when the DB column has the same default.
- The model must contain only real columns. No computed or UI-only values in table models.

## 5. Foreign key rules

1. **The FK is always stored as a plain id field** (`userId`), typed to match the parent's primary key. The id is the source of truth.
2. **Never make the related object a required field.** A row from the table does not contain the parent object.
3. If the related object is needed, add it as an **optional nullable field excluded from serialization**:
   ```dart
   @JsonKey(includeFromJson: false, includeToJson: false) User? user,
   ```
   This keeps it out of insert/update maps so the DB never sees a nonexistent column.
4. **Nullable FK** (optional relationship): `@JsonKey(name: 'category_id') int? categoryId`.
5. **Name FK fields** `<parentSingular>Id` (`userId`, `categoryId`) mapped to `<parent>_id`.
6. Do not nest the parent's `fromJson` inside the child's `fromJson` for table models. Hydrate relations in the repository (see section 7).
7. Composite or many-to-many relations: model the join table as its own Freezed class with both FK ids (`PostTag { postId, tagId }`).

## 6. Aggregate / view models

When the UI needs parent with children, create a separate non-table model assembled in the repository:

```dart
@freezed
abstract class UserWithPosts with _$UserWithPosts {
  const factory({
    required User user,
    @Default([]) List<Post> posts,
  }) = _UserWithPosts;
}
```

- Aggregate models do not need `fromJson`/`toJson` and must never be passed to `insert`/`update`.
- Suffix them clearly (`WithPosts`, `Detail`, `View`).

## 7. Loading relations

- Plain query -> `Model.fromJson(row)`; relation field stays `null`.
- With JOIN -> alias joined columns (`u.name AS u_name`), build the parent object manually, then attach with `copyWith`:
  ```dart
  final post = Post.fromJson(row).copyWith(user: User(...));
  ```
- Relation loading lives in the repository/DAO layer, never in widgets.

## 8. Type converters

- SQLite has no bool or DateTime types. Use converters, never manual casting in the UI.
- Bool stored as 0/1:
  ```dart
  class BoolIntConverter implements JsonConverter<bool, int> {
    const BoolIntConverter();
    @override
    bool fromJson(int json) => json == 1;
    @override
    int toJson(bool object) => object ? 1 : 0;
  }
  ```
  Usage: `@BoolIntConverter() @JsonKey(name: 'is_active') required bool isActive`.
- Create a similar converter for any custom storage format (e.g. epoch ints for dates, JSON strings for lists).

## 9. Insert / update rules

- Insert/update with `model.toJson()`.
- For auto-increment ids, make the field nullable (`int? id`) or use a separate `NewPost` / companion model so `id` is omitted on insert.
- Immutable models: change data only via `copyWith`, never by mutation.

## 10. Code generation

After any model change run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Use `watch` instead of `build` during active development.

## 11. Checklist before finishing a model

- [ ] `abstract class` + `with _$Name` + `= _Name`
- [ ] Both `part` directives present
- [ ] `fromJson` factory defined
- [ ] All snake_case columns mapped with `@JsonKey(name: ...)`
- [ ] FKs are plain id fields (nullable if the column is nullable)
- [ ] Relation objects are optional and excluded from JSON
- [ ] Converters applied for bool/date columns
- [ ] `build_runner` run successfully
