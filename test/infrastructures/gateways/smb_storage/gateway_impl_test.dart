import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/infrastructures/gateways/smb_storage/gateway_impl.dart';

void main() {
  group('SmbStorageGatewayImpl.getStatus', () {
    test('returns storage metrics even when socket probe is offline', () async {
      const gateway = SmbStorageGatewayImpl();
      final now = DateTime.now().toUtc();
      final connection = ConnectionModel(
        id: 'smb-1',
        protocol: ConnectionProtocol.smb,
        displayName: 'Test SMB',
        remoteAddress: '127.0.0.1',
        username: 'admin',
        password: EncryptedValueModel(
          id: 'enc-1',
          salt: 's',
          nonce: 'n',
          cipherText: 'c',
          mac: 'm',
          createdAt: now,
          updatedAt: now,
        ),
        createdAt: now,
        updatedAt: now,
      );

      final status = await gateway.getStatus(connection: connection);

      expect(status.totalBytes, 500 * 1024 * 1024 * 1024);
      expect(status.freeBytes, 64 * 1024 * 1024 * 1024);
      expect(status.updatedAt, isNotNull);
    });
  });
}
