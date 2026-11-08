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
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'user',
        password: 'pwd',
        displayName: 'Custom Name',
      );

      final draft = mapper.toDraftDto(dto);

      expect(draft.protocol, ConnectionProtocol.webdav);
      expect(draft.remoteAddress, 'https://example.com');
      expect(draft.username, 'user');
      expect(draft.password, 'pwd');
      expect(draft.displayName, 'Custom Name');
    });

    test('toDraftDto falls back to remoteAddress when displayName is null', () {
      const dto = ConnectionDto(
        protocol: ConnectionProtocol.webdav,
        remoteAddress: 'https://example.com',
        username: 'user',
        password: 'pwd',
      );

      final draft = mapper.toDraftDto(dto);

      expect(draft.displayName, 'https://example.com');
    });

    test(
      'toConnectionModel maps ConnectionDraftDto to ConnectionModel with date',
      () {
        final testDate = DateTime.utc(2026, 11, 7, 12);
        const draft = ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://example.com',
          username: 'user',
          password: 'pwd',
          displayName: 'My WebDAV',
        );

        final model = mapper.toConnectionModel(draft, date: testDate);

        expect(model.id, isNotEmpty);
        expect(model.protocol, ConnectionProtocol.webdav);
        expect(model.displayName, 'My WebDAV');
        expect(model.remoteAddress, 'https://example.com');
        expect(model.username, 'user');
        expect(model.password?.cipherText, 'pwd');
        expect(model.rootPath, '/');
        expect(model.createdAt, testDate);
        expect(model.updatedAt, testDate);
        expect(model.password?.createdAt, testDate);
        expect(model.password?.updatedAt, testDate);
      },
    );

    test(
      'toConnectionModel defaults date to current UTC time when omitted',
      () {
        const draft = ConnectionDraftDto(
          protocol: ConnectionProtocol.webdav,
          remoteAddress: 'https://example.com',
          username: 'user',
          password: 'pwd',
          displayName: 'My WebDAV',
        );

        final before = DateTime.now().toUtc().subtract(
          const Duration(seconds: 1),
        );
        final model = mapper.toConnectionModel(draft);
        final after = DateTime.now().toUtc().add(const Duration(seconds: 1));

        expect(model.createdAt.isAfter(before), isTrue);
        expect(model.createdAt.isBefore(after), isTrue);
      },
    );

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
