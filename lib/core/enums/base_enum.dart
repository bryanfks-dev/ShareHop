abstract class BaseEnum {
  const new({required this.persistentValue});

  final String persistentValue;
}

extension PersistentEnumLookup<T extends BaseEnum> on Iterable<T> {
  T fromPersistentValue(String value) => firstWhere(
    (e) => e.persistentValue == value,
    orElse: () => throw ArgumentError('Invalid persistent value of $T: $value'),
  );
}
