import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid_value.dart';

class UuidValueConverter implements JsonConverter<UuidValue, String> {
  const new();

  @override
  UuidValue fromJson(String json) => UuidValue.fromString(json);

  @override
  String toJson(UuidValue object) => object.uuid;
}
