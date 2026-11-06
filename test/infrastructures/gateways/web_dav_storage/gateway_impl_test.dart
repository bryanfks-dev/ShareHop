// Dio is a transitive dependency of webdav_client used for mock responses.
// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/web_dav_credential_model.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/error.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/gateway_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class FakeWdDio extends webdav.WdDio {
  Response<String>? propfindResponse;
  bool shouldThrow = false;
  String? capturedPath;
  bool? capturedDepth;
  String? capturedDataStr;

  @override
  Future<Response<dynamic>> wdPropfind(
    webdav.Client self,
    String path,
    bool depth,
    String dataStr, {
    CancelToken? cancelToken,
  }) async {
    if (shouldThrow) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: path),
          statusCode: 500,
        ),
      );
    }
    capturedPath = path;
    capturedDepth = depth;
    capturedDataStr = dataStr;
    return propfindResponse!;
  }
}

class FakeWebDavClientManager extends WebDavClientManager {
  new(this.client) : super(WebDavClientPool());

  final webdav.Client client;

  @override
  Future<T> useClientWithDisposal<T>(
    Future<T> Function(webdav.Client client) action, {
    required WebDavCredentialModel credential,
  }) async {
    return await action(client);
  }
}

void main() {
  group('WebDavStorageGatewayImpl.getStatus', () {
    late FakeWdDio fakeDio;
    late webdav.Client fakeClient;
    late FakeWebDavClientManager fakeClientManager;
    late WebDavStorageGatewayImpl service;

    final credential = WebDavCredentialModel(
      url: Uri.parse('https://example.com/dav'),
      username: 'user',
      password: 'password',
    );

    setUp(() {
      fakeDio = FakeWdDio();
      fakeClient = webdav.Client(
        uri: 'https://example.com/dav',
        c: fakeDio,
        auth: const webdav.Auth(user: '', pwd: ''),
      );
      fakeClientManager = FakeWebDavClientManager(fakeClient);
      service = WebDavStorageGatewayImpl(fakeClientManager);
    });

    test('returns parsed storage status when response contains quota bytes',
        () async {
      fakeDio.propfindResponse = Response(
        requestOptions: RequestOptions(path: '/'),
        statusCode: 207,
        data: '''
<?xml version="1.0" encoding="utf-8" ?>
<D:multistatus xmlns:D="DAV:">
  <D:response>
    <D:propstat>
      <D:prop>
        <D:quota-available-bytes>68719476736</D:quota-available-bytes>
        <D:quota-used-bytes>468159184896</D:quota-used-bytes>
      </D:prop>
      <D:status>HTTP/1.1 200 OK</D:status>
    </D:propstat>
  </D:response>
</D:multistatus>''',
      );

      final status = await service.getStatus(credential: credential);

      expect(status.freeBytes, 68719476736);
      expect(status.usedBytes, 468159184896);
      expect(status.totalBytes, 536878661632);
      expect(fakeDio.capturedPath, '/');
      expect(fakeDio.capturedDepth, isFalse);
    });

    test('normalizes custom path correctly', () async {
      fakeDio.propfindResponse = Response(
        requestOptions: RequestOptions(path: '/files'),
        statusCode: 207,
        data: '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:propstat>
      <d:prop>
        <d:quota-available-bytes>1000</d:quota-available-bytes>
        <d:quota-used-bytes>2000</d:quota-used-bytes>
      </d:prop>
    </d:propstat>
  </d:response>
</d:multistatus>''',
      );

      final status = await service.getStatus(
        credential: credential,
        path: 'files',
      );

      expect(fakeDio.capturedPath, '/files');
      expect(status.totalBytes, 3000);
      expect(status.freeBytes, 1000);
      expect(status.usedBytes, 2000);
    });

    test('handles negative available bytes gracefully', () async {
      fakeDio.propfindResponse = Response(
        requestOptions: RequestOptions(path: '/'),
        statusCode: 207,
        data: '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:propstat>
      <d:prop>
        <d:quota-available-bytes>-3</d:quota-available-bytes>
        <d:quota-used-bytes>5000</d:quota-used-bytes>
      </d:prop>
    </d:propstat>
  </d:response>
</d:multistatus>''',
      );

      final status = await service.getStatus(credential: credential);

      expect(status.freeBytes, 0);
      expect(status.usedBytes, 5000);
      expect(status.totalBytes, 5000);
    });

    test('throws WebDavOperationFailedError when quota properties missing',
        () async {
      fakeDio.propfindResponse = Response(
        requestOptions: RequestOptions(path: '/'),
        statusCode: 207,
        data: '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:propstat>
      <d:prop>
        <d:displayname>Test</d:displayname>
      </d:prop>
    </d:propstat>
  </d:response>
</d:multistatus>''',
      );

      expect(
        () => service.getStatus(credential: credential),
        throwsA(isA<WebDavOperationFailedError>()),
      );
    });

    test('throws WebDavOperationFailedError when request fails', () async {
      fakeDio.shouldThrow = true;

      expect(
        () => service.getStatus(credential: credential),
        throwsA(isA<WebDavOperationFailedError>()),
      );
    });
  });
}
