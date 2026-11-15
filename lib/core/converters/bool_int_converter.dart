import 'package:json_annotation/json_annotation.dart';

class BoolIntConverter implements JsonConverter<bool, int> {
  const new();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}
