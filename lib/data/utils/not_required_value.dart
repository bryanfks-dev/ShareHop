import 'package:freezed_annotation/freezed_annotation.dart';

part 'not_required_value.freezed.dart';

@freezed
abstract class NotRequiredValue<T> with _$NotRequiredValue<T> {
  const factory(T? value) = _NotRequiredValue<T>;
}
