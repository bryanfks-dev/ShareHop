import 'package:sharehop/core/repositories/connection/dto.dart';

Map<String, dynamic> mapConnectionRevisionDtoToUpdateValues(
  ConnectionRevisionDto revision,
) {
  final values = <String, dynamic>{
    'updated_at': DateTime.now().toUtc().toIso8601String(),
  };

  if (revision.displayName != null) {
    values['display_name'] = revision.displayName;
  }
  if (revision.remoteAddress != null) {
    values['remote_address'] = revision.remoteAddress;
  }

  return values;
}
