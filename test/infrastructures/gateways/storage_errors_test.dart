import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/infrastructures/gateways/smb_storage/error.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';

void main() {
  group('Storage Gateway Errors', () {
    test('SmbOperationFailedError retains message', () {
      final error = SmbOperationFailedError(message: 'SMB read timeout');
      expect(error.message, 'SMB read timeout');
    });

    test('WebDavOperationFailedError retains message', () {
      final error = WebDavOperationFailedError(message: 'WebDAV 404 Not Found');
      expect(error.message, 'WebDAV 404 Not Found');
    });
  });
}
