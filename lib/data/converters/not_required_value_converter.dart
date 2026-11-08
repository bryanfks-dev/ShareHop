import 'package:json_annotation/json_annotation.dart';
import 'package:sharehop/data/utils/not_required_value.dart';

class NotRequiredValueConverter<T>
    implements JsonConverter<NotRequiredValue<T>?, dynamic> {
  const new();

  @override
  NotRequiredValue<T>? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return NotRequiredValue<T>(json as T);
  }

  @override
  dynamic toJson(NotRequiredValue<T>? object) {
    if (object == null) {
      return null;
    }
    return object.value;
  }
}
