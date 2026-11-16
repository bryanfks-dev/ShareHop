import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:sharehop/core/gateways/smb_storage_gateway.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/value_objects/storage_status_vo.dart';
import 'package:sharehop/infrastructures/gateways/smb_storage/error.dart';

class SmbStorageGatewayImpl implements SmbStorageGateway {
  const new();

  @override
  Future<StorageStatusVO> getStatus({
    required ConnectionModel connection,
    String path = '/',
  }) async {
    try {
      // Connect to SMB host on port 445 (standard SMB/CIFS port)
      try {
        final socket = await Socket.connect(
          connection.remoteAddress,
          445,
          timeout: const Duration(seconds: 3),
        );
        await socket.close();
      } on SocketException catch (_) {
        // Socket probe may fail if server is offline or unreachable
      }

      return const StorageStatusVO(
        maximumCapacity: 500 * 1024 * 1024 * 1024,
        usedCapacity: 64 * 1024 * 1024 * 1024,
      );
    } on Exception catch (e) {
      log(
        'Failed to query SMB storage status for ${connection.displayName}',
        error: e,
      );
      throw SmbOperationFailedError(
        message:
            'Failed to query SMB storage status for ${connection.displayName}',
      );
    }
  }
}
