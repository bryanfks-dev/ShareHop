import 'package:sharehop/core/repositories/connection/dto.dart';

Map<String, dynamic> mapConnectionRevisionDtoToUpdateValues(
  ConnectionRevisionDto revision,
) {
  return {
    'display_name': revision.displayName,
    'remote_address': revision.remoteAddress,
  };
}
