import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/core/models/encrypted_value_model.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/core/models/pinned_connection_model.dart';

void main() {
  final now = DateTime.utc(2026, 11, 7, 12);

  group('EncryptedValueModel', () {
    test('serializes to and from JSON correctly', () {
      final model = EncryptedValueModel(
        id: 'enc-1',
        salt: 'salt123',
        nonce: 'nonce123',
        cipherText: 'cipher123',
        mac: 'mac123',
        createdAt: now,
        updatedAt: now,
      );

      final json = model.toJson();
      expect(json['id'], 'enc-1');
      expect(json['salt'], 'salt123');
      expect(json['nonce'], 'nonce123');
      expect(json['cipher_text'], 'cipher123');
      expect(json['mac'], 'mac123');

      final fromJson = EncryptedValueModel.fromJson(json);
      expect(fromJson, model);
      expect(EncryptedValueModel.tableName, 'encrypted_values');
    });
  });

  group('ConnectionModel', () {
    test('instantiates and supports copyWith and tableName', () {
      final enc = EncryptedValueModel(
        id: 'enc-1',
        salt: 'salt123',
        nonce: 'nonce123',
        cipherText: 'cipher123',
        mac: 'mac123',
        createdAt: now,
        updatedAt: now,
      );

      final connection = ConnectionModel(
        id: 'conn-1',
        protocol: ConnectionProtocol.webdav,
        displayName: 'My WebDAV',
        remoteAddress: 'https://dav.example.com',
        username: 'admin',
        passwordId: enc.id,
        password: enc,
        createdAt: now,
        updatedAt: now,
        rootPath: '/remote.php/webdav',
      );

      expect(connection.id, 'conn-1');
      expect(connection.protocol, ConnectionProtocol.webdav);
      expect(connection.displayName, 'My WebDAV');
      expect(connection.remoteAddress, 'https://dav.example.com');
      expect(connection.rootPath, '/remote.php/webdav');

      final copied = connection.copyWith(
        displayName: 'Renamed WebDAV',
        rootPath: '/new/path',
      );
      expect(copied.displayName, 'Renamed WebDAV');
      expect(copied.rootPath, '/new/path');
      expect(copied.id, connection.id);
      expect(ConnectionModel.tableName, 'connections');
    });
  });

  group('PinnedConnectionModel', () {
    test('instantiates correctly and provides tableName', () {
      final enc = EncryptedValueModel(
        id: 'enc-1',
        salt: 'salt123',
        nonce: 'nonce123',
        cipherText: 'cipher123',
        mac: 'mac123',
        createdAt: now,
        updatedAt: now,
      );

      final connection = ConnectionModel(
        id: 'conn-1',
        protocol: ConnectionProtocol.webdav,
        displayName: 'My WebDAV',
        remoteAddress: 'https://dav.example.com',
        username: 'admin',
        passwordId: enc.id,
        password: enc,
        createdAt: now,
        updatedAt: now,
        rootPath: '/webdav',
      );

      final pinned = PinnedConnectionModel(
        id: 'pin-1',
        connectionId: connection.id,
        connection: connection,
        createdAt: now,
        updatedAt: now,
      );

      expect(pinned.connection?.id, connection.id);
      expect(PinnedConnectionModel.tableName, 'pinned_connections');
    });
  });

  group('FileTransferHistoryModel', () {
    test('serializes to and from JSON correctly', () {
      final transfer = FileTransferHistoryModel(
        id: 'transfer-1',
        fileName: 'report.pdf',
        fileSize: 1048576,
        fileMimeType: 'application/pdf',
        sourceName: 'My WebDAV',
        destinationName: 'Local Storage',
        status: FileTransferStatus.completed,
        createdAt: now,
        updatedAt: now,
      );

      final json = transfer.toJson();
      expect(json['id'], 'transfer-1');
      expect(json['file_name'], 'report.pdf');
      expect(json['file_size'], 1048576);
      expect(json['status'], 'completed');

      final deserialized = FileTransferHistoryModel.fromJson(json);
      expect(deserialized, transfer);
      expect(FileTransferHistoryModel.tableName, 'file_transfer_histories');
    });
  });

  group('AppConfigModel', () {
    test('supports copyWith and equality', () {
      final config = AppConfigModel(
        isWifiOnlyTransfersEnabled: true,
        isBackgroundTransfersEnabled: false,
        simultaneousTransfersLimit: 5,
        onFileConflictsResolution: FileConflictsResolution.rename,
        isBiometricLockEnabled: true,
        downloadDestinationPath: '/downloads',
        appAppearance: AppTheme.dark,
      );

      expect(config.isWifiOnlyTransfersEnabled, isTrue);
      expect(config.isBackgroundTransfersEnabled, isFalse);
      expect(config.simultaneousTransfersLimit, 5);
      expect(config.appAppearance, AppTheme.dark);

      final copied = config.copyWith(simultaneousTransfersLimit: 10);
      expect(copied.simultaneousTransfersLimit, 10);
      expect(copied.isWifiOnlyTransfersEnabled, isTrue);
    });
  });
}
