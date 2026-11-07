import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';

void main() {
  late ConnectionMapper mapper;

  setUp(() {
    mapper = ConnectionMapper(EncryptedValueMapper());
  });

  group('ConnectionMapper', () {
    test('toDraftDto maps ConnectionDto to ConnectionDraftDto', () {
      const dto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'user',
        password: 'pwd',
        displayName: 'Custom Name',
      );

      final draft = mapper.toDraftDto(dto);

      expect(draft.connectionProtocol, ConnectionProtocol.webdav);
      expect(draft.remoteAddress, 'https://example.com');
      expect(draft.username, 'user');
      expect(draft.password, 'pwd');
      expect(draft.displayName, 'Custom Name');
    });

    test('toDraftDto falls back to remoteAddress when displayName is null', () {
      const dto = ConnectionDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'user',
        password: 'pwd',
      );

      final draft = mapper.toDraftDto(dto);

      expect(draft.displayName, 'https://example.com');
    });

    test('toConnectionModel maps ConnectionDraftDto to ConnectionModel', () {
      const draft = ConnectionDraftDto(
        connectionProtocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'user',
        password: 'pwd',
        displayName: 'My WebDAV',
      );

      final model = mapper.toConnectionModel(draft);

      expect(model.id, isNotEmpty);
      expect(model.protocol, ConnectionProtocol.webdav);
      expect(model.displayName, 'My WebDAV');
      expect(model.remoteAddress, 'https://example.com');
      expect(model.username, 'user');
      expect(model.password?.cipherText, 'pwd');
      expect(model.rootPath, '/');
      expect(model.createdAt, isNotNull);
      expect(model.updatedAt, isNotNull);
    });

    test(
      'toConnectionViewModel maps ConnectionModel to ConnectionViewModel',
      () {
        final now = DateTime.now().toUtc();
        final model = ConnectionModel(
          id: 'conn-id',
          protocol: ConnectionProtocol.webdav,
          displayName: 'Server',
          remoteAddress: 'https://server.com',
          username: 'admin',
          password: EncryptedValueModel(
            id: 'pwd-id',
            salt: '',
            cipherText: 'encrypted_secret',
            nonce: '',
            mac: '',
            createdAt: now,
            updatedAt: now,
          ),
          createdAt: now,
          updatedAt: now,
        );

        final vm = mapper.toConnectionViewModel(model, isPinned: true);

        expect(vm.id, 'conn-id');
        expect(vm.protocol, ConnectionProtocol.webdav);
        expect(vm.displayName, 'Server');
        expect(vm.remoteAddress, 'https://server.com');
        expect(vm.username, 'admin');
        expect(vm.password, 'encrypted_secret');
        expect(vm.isPinned, isTrue);
      },
    );
  });
}
