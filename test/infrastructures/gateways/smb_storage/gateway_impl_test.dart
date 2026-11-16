import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/infrastructures/gateways/smb_storage/gateway_impl.dart';
import 'package:uuid/uuid_value.dart';

void main() {
  group('SmbStorageGatewayImpl.getStatus', () {
    test('returns storage metrics even when socket probe is offline', () async {
      const gateway = SmbStorageGatewayImpl();
      final now = DateTime.now().toUtc();
      final encId = UuidValue.fromString(
        '11111111-1111-1111-1111-111111111111',
      );
      final connId = UuidValue.fromString(
        '22222222-2222-2222-2222-222222222222',
      );
      final encModel = EncryptedValueModel(
        id: encId,
        salt: 's',
        nonce: 'n',
        cipherText: 'c',
        mac: 'm',
        createdAt: now,
        updatedAt: now,
      );
      final connection = ConnectionModel(
        id: connId,
        protocol: ConnectionProtocol.smb,
        displayName: 'Test SMB',
        remoteAddress: '127.0.0.1',
        username: 'admin',
        passwordId: encId,
        password: encModel,
        rootPath: '/share',
        createdAt: now,
        updatedAt: now,
      );

      final status = await gateway.getStatus(connection: connection);

      expect(status.maximumCapacity, 500 * 1024 * 1024 * 1024);
      expect(status.usedCapacity, 64 * 1024 * 1024 * 1024);
    });
  });
}
