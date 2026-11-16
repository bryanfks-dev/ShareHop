import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:uuid/uuid.dart';

void main() {
  late ConnectionMapper mapper;

  setUp(() {
    mapper = const ConnectionMapper(EncryptedValueMapper());
  });

  group('ConnectionMapper', () {
    test('toConnectionModel maps db row with joined encrypted_value to '
        'ConnectionModel', () {
      final id = const Uuid().v7();
      final passwordId = const Uuid().v7();
      final now = DateTime.now().toUtc().toIso8601String();

      final row = <String, dynamic>{
        'id': id,
        'protocol': 'webdav',
        'display_name': 'My Server',
        'remote_address': 'https://dav.example.com',
        'username': 'admin',
        'password_id': passwordId,
        'root_path': '/remote.php/dav/files/admin',
        'allow_self_signed_certificate': 1,
        'created_at': now,
        'updated_at': now,
        'ev_id': passwordId,
        'ev_salt': 'salt123',
        'ev_nonce': 'nonce123',
        'ev_cipher_text': 'cipher123',
        'ev_mac': 'mac123',
        'ev_created_at': now,
        'ev_updated_at': now,
      };

      final model = mapper.toConnectionModel(row);

      expect(model.id.uuid, id);
      expect(model.protocol, ConnectionProtocol.webdav);
      expect(model.displayName, 'My Server');
      expect(model.remoteAddress, 'https://dav.example.com');
      expect(model.username, 'admin');
      expect(model.passwordId.uuid, passwordId);
      expect(model.rootPath, '/remote.php/dav/files/admin');
      expect(model.allowSelfSignedCertificate, isTrue);
      expect(model.password, isNotNull);
      expect(model.password?.id.uuid, passwordId);
      expect(model.password?.cipherText, 'cipher123');
      expect(model.password?.salt, 'salt123');
      expect(model.password?.nonce, 'nonce123');
      expect(model.password?.mac, 'mac123');

      final modelFromAlias = mapper.toConnectionModel(row);
      expect(modelFromAlias, model);
    });

    test(
      'toConnectionModel maps db row without encrypted_value (null ev_id)',
      () {
        final id = const Uuid().v7();
        final passwordId = const Uuid().v7();
        final now = DateTime.now().toUtc().toIso8601String();

        final row = <String, dynamic>{
          'id': id,
          'protocol': 'sftp',
          'display_name': 'SFTP Server',
          'remote_address': 'sftp://example.com',
          'username': 'root',
          'password_id': passwordId,
          'root_path': '/',
          'created_at': now,
          'updated_at': now,
        };

        final model = mapper.toConnectionModel(row);

        expect(model.id.uuid, id);
        expect(model.protocol, ConnectionProtocol.sftp);
        expect(model.password, isNull);
      },
    );

    test(
      'toConnectionViewModel maps ConnectionModel to ConnectionViewModel',
      () {
        final now = DateTime.now().toUtc();
        final model = ConnectionModel(
          id: const Uuid().v7obj(),
          protocol: ConnectionProtocol.webdav,
          displayName: 'Server',
          remoteAddress: 'https://server.com',
          username: 'admin',
          passwordId: const Uuid().v7obj(),
          password: EncryptedValueModel(
            id: const Uuid().v7obj(),
            salt: '',
            cipherText: 'encrypted_secret',
            nonce: '',
            mac: '',
            createdAt: now,
            updatedAt: now,
          ),
          rootPath: '/',
          allowSelfSignedCertificate: true,
          createdAt: now,
          updatedAt: now,
        );

        final vm = mapper.toConnectionViewModel(model, isPinned: true);

        expect(vm.id, model.id);
        expect(vm.protocol, ConnectionProtocol.webdav);
        expect(vm.displayName, 'Server');
        expect(vm.remoteAddress, 'https://server.com');
        expect(vm.username, 'admin');
        expect(vm.password, 'encrypted_secret');
        expect(vm.rootPath, '/');
        expect(vm.allowSelfSignedCertificate, isTrue);
        expect(vm.isPinned, isTrue);
      },
    );
  });
}
