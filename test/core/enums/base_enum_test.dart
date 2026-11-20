import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/base_enum.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';

void main() {
  group('PersistentEnumLookup', () {
    test('fromPersistentValue resolves valid persistent value', () {
      expect(
        AppTheme.values.fromPersistentValue(value: 'light'),
        AppTheme.light,
      );
      expect(
        AppTheme.values.fromPersistentValue(value: 'dark'),
        AppTheme.dark,
      );
      expect(
        AppTheme.values.fromPersistentValue(value: 'system'),
        AppTheme.system,
      );

      expect(
        ConnectionProtocol.values.fromPersistentValue(value: 'sftp'),
        ConnectionProtocol.sftp,
      );
      expect(
        ConnectionProtocol.values.fromPersistentValue(value: 'webdav'),
        ConnectionProtocol.webdav,
      );

      expect(
        ConnectionStatus.values.fromPersistentValue(value: 'online'),
        ConnectionStatus.online,
      );

      expect(
        FileConflictsResolution.values.fromPersistentValue(value: 'overwrite'),
        FileConflictsResolution.overwrite,
      );

      expect(
        FileTransferStatus.values.fromPersistentValue(value: 'in_progress'),
        FileTransferStatus.inProgress,
      );
    });

    test('fromPersistentValue throws ArgumentError on unknown value', () {
      expect(
        () => AppTheme.values.fromPersistentValue(value: 'invalid_theme'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => ConnectionProtocol.values.fromPersistentValue(value: 'unknown'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
