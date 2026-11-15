import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/dto/connection_dto.dart';
import 'package:sharehop/data/utils/not_required_value.dart';
import 'package:sharehop/infrastructures/database/utils/not_required_value_map_util.dart';

void main() {
  group('ConnectionRevisionDto.toMap', () {
    test('generates updated_at field with current UTC time by default', () {
      final before = DateTime.now().toUtc().subtract(
        const Duration(seconds: 1),
      );
      const revision = ConnectionRevisionDto(id: 'conn-1');

      final map = revision.toMap();

      expect(map['id'], 'conn-1');
      expect(map.containsKey('updated_at'), isTrue);
      expect(map['updated_at'], isA<NotRequiredValue<String>>());

      final updatedValue =
          (map['updated_at'] as NotRequiredValue<String>).value;
      expect(updatedValue, isNotNull);

      final parsed = DateTime.parse(updatedValue!);
      expect(parsed.isAfter(before), isTrue);
      final after = DateTime.now().toUtc().add(const Duration(seconds: 1));
      expect(parsed.isBefore(after), isTrue);
    });

    test('generates updated_at field using provided updatedAt parameter', () {
      final customDate = DateTime.utc(2026, 5, 20, 10, 30);
      const revision = ConnectionRevisionDto(id: 'conn-2');

      final map = revision.toMap(updatedAt: customDate);

      expect(
        map['updated_at'],
        NotRequiredValue(customDate.toIso8601String()),
      );
    });

    test('maps all revision fields correctly', () {
      final customDate = DateTime.utc(2026, 11, 10, 20);
      const revision = ConnectionRevisionDto(
        id: 'conn-3',
        protocol: NotRequiredValue(ConnectionProtocol.webdav),
        remoteAddress: NotRequiredValue('https://dav.test'),
        username: NotRequiredValue('user1'),
        passwordSecretKey: NotRequiredValue('secret-key'),
        password: NotRequiredValue('mypassword'),
        displayName: NotRequiredValue('Test Server'),
        rootPath: NotRequiredValue('/data'),
      );

      final map = revision.toMap(updatedAt: customDate);

      expect(map, {
        'id': 'conn-3',
        'protocol': const NotRequiredValue(ConnectionProtocol.webdav),
        'remote_address': const NotRequiredValue('https://dav.test'),
        'username': const NotRequiredValue('user1'),
        'password_secret_key': const NotRequiredValue('secret-key'),
        'password': const NotRequiredValue('mypassword'),
        'display_name': const NotRequiredValue('Test Server'),
        'root_path': const NotRequiredValue('/data'),
        'updated_at': NotRequiredValue(customDate.toIso8601String()),
      });
    });

    test(
      'works with forEachNotRequiredValueMap to extract updated_at into db map',
      () {
        final customDate = DateTime.utc(2026, 11, 10, 20);
        const revision = ConnectionRevisionDto(
          id: 'conn-4',
          displayName: NotRequiredValue('Updated Display'),
        );

        final dbValues = <String, dynamic>{};
        forEachNotRequiredValueMap(
          revision.toMap(updatedAt: customDate),
          (key, value) {
            dbValues[key] = value;
          },
        );

        expect(dbValues['display_name'], 'Updated Display');
        expect(dbValues['updated_at'], customDate.toIso8601String());
        expect(dbValues.containsKey('id'), isFalse);
      },
    );
  });
}
