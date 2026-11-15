import 'package:sharehop/core/enums/base_enum.dart';
import 'package:sharehop/data/utils/not_required_value.dart';

void forEachNotRequiredValueMap(
  Map<String, dynamic> map,
  void Function(String key, dynamic value) onValue, {
  bool skipId = true,
}) {
  final databaseMap = _toDatabaseMap(map, skipId: skipId);
  for (final entry in databaseMap.entries) {
    onValue(entry.key, entry.value);
  }
}

Map<String, dynamic> _toDatabaseMap(
  Map<String, dynamic> map, {
  bool skipId = true,
}) {
  final values = <String, dynamic>{};
  for (final entry in map.entries) {
    if (skipId && entry.key == 'id') {
      continue;
    }

    final notRequired = entry.value;
    if (notRequired is! NotRequiredValue || notRequired.value == null) {
      continue;
    }

    final rawValue = notRequired.value;
    values[entry.key] = _sanitizedValue(rawValue);
  }

  return values;
}

dynamic _sanitizedValue(dynamic value) {
  if (value is BaseEnum) {
    return value.persistentValue;
  }
  if (value is Enum) {
    return value.name;
  }
  return value;
}
