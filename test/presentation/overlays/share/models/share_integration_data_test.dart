import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';

void main() {
  group('SharedFileInfo', () {
    test('instantiates with defaults and formats size', () {
      const info = SharedFileInfo(
        name: 'test.png',
        size: 1048576,
        mimeType: 'image/png',
        uri: 'file:///test.png',
      );

      expect(info.name, 'test.png');
      expect(info.size, 1048576);
      expect(info.mimeType, 'image/png');
      expect(info.uri, 'file:///test.png');
      expect(info.formattedSize, '1.0 MB');
    });

    test('equality and hashCode', () {
      const info1 = SharedFileInfo(name: 'a.txt', size: 100, uri: 'u1');
      const info2 = SharedFileInfo(name: 'a.txt', size: 100, uri: 'u1');
      const info3 = SharedFileInfo(name: 'b.txt', size: 100, uri: 'u2');

      expect(info1, info2);
      expect(info1.hashCode, info2.hashCode);
      expect(info1, isNot(info3));
    });
  });

  group('ShareIntegrationItem', () {
    test('default constructor provides fallback mock values', () {
      const item = ShareIntegrationItem();

      expect(item.title, 'Campaign selects');
      expect(item.subtitle, '3 JPEG images');
      expect(item.fileCount, 3);
      expect(item.totalSize, '24.8 MB');
      expect(item.files.length, 3);
      expect(item.excludedFiles, isEmpty);
    });

    test('fromFiles with empty active files returns no files selected', () {
      final item = ShareIntegrationItem.fromFiles(
        activeFiles: const [],
        excludedFiles: const [SharedFileInfo(name: 'excluded.jpg')],
      );

      expect(item.title, 'No files selected');
      expect(item.subtitle, 'All files excluded');
      expect(item.fileCount, 0);
      expect(item.totalSize, '0 B');
      expect(item.files, isEmpty);
      expect(item.excludedFiles.length, 1);
    });

    test('fromFiles with 1 active file formats title and subtitle', () {
      final itemWithMime = ShareIntegrationItem.fromFiles(
        activeFiles: const [
          SharedFileInfo(
            name: 'photo.jpg',
            size: 2097152,
            mimeType: 'image/jpeg',
          ),
        ],
      );

      expect(itemWithMime.title, 'photo.jpg');
      expect(itemWithMime.subtitle, '2.0 MB · image/jpeg');
      expect(itemWithMime.fileCount, 1);
      expect(itemWithMime.totalSize, '2.0 MB');

      final itemWithoutMime = ShareIntegrationItem.fromFiles(
        activeFiles: const [
          SharedFileInfo(name: 'data.bin', size: 1024),
        ],
      );

      expect(itemWithoutMime.title, 'data.bin');
      expect(itemWithoutMime.subtitle, '1.0 KB');
      expect(itemWithoutMime.fileCount, 1);
    });

    test('fromFiles with multiple active files formats count and summary', () {
      final item = ShareIntegrationItem.fromFiles(
        activeFiles: const [
          SharedFileInfo(name: 'first.jpg', size: 1048576),
          SharedFileInfo(name: 'second.jpg', size: 2097152),
          SharedFileInfo(name: 'third.jpg', size: 1048576),
        ],
      );

      expect(item.title, 'first.jpg + 2 more');
      expect(item.subtitle, '3 files · 4.0 MB');
      expect(item.fileCount, 3);
      expect(item.totalSize, '4.0 MB');
    });

    test('copyWith updates fields', () {
      const item = ShareIntegrationItem();
      final updated = item.copyWith(
        title: 'New Title',
        fileCount: 10,
        totalSize: '100 MB',
      );

      expect(updated.title, 'New Title');
      expect(updated.fileCount, 10);
      expect(updated.totalSize, '100 MB');
      expect(updated.subtitle, item.subtitle);
    });
  });

  group('ShareIntegrationDestination', () {
    test('default constructor provides fallback values', () {
      const dest = ShareIntegrationDestination();

      expect(dest.name, 'Production');
      expect(dest.host, 'prod.relaydock.io');
      expect(dest.protocol, ConnectionProtocol.sftp);
      expect(dest.status, ConnectionStatus.online);
      expect(dest.destinationPath, '/var/www/releases/assets');
    });

    test('copyWith updates destination properties', () {
      const dest = ShareIntegrationDestination();
      final updated = dest.copyWith(
        name: 'Staging',
        host: 'staging.local',
        protocol: ConnectionProtocol.webdav,
        status: ConnectionStatus.offline,
        destinationPath: '/remote/dav',
      );

      expect(updated.name, 'Staging');
      expect(updated.host, 'staging.local');
      expect(updated.protocol, ConnectionProtocol.webdav);
      expect(updated.status, ConnectionStatus.offline);
      expect(updated.destinationPath, '/remote/dav');
    });
  });

  group('ShareIntegrationData', () {
    test('default constructor sets simultaneousTransfers to 3', () {
      const data = ShareIntegrationData();

      expect(data.preserveOriginalFilenames, isTrue);
      expect(data.simultaneousTransfers, 3);
      expect(data.item.fileCount, 3);
      expect(data.destination.name, 'Production');
    });

    test('copyWith updates simultaneousTransfers and other properties', () {
      const data = ShareIntegrationData();
      final updated = data.copyWith(
        preserveOriginalFilenames: false,
        simultaneousTransfers: 5,
      );

      expect(updated.preserveOriginalFilenames, isFalse);
      expect(updated.simultaneousTransfers, 5);
      expect(updated.item, data.item);
      expect(updated.destination, data.destination);
    });
  });
}
