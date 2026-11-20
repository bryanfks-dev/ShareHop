import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:sharehop/core/errors/auth.dart';
import 'package:sharehop/infrastructures/gateways/biometric_gateway_impl.dart';

class _FakeLocalAuthPlatform extends LocalAuthPlatform {
  bool canCheck = true;
  bool isSupported = true;
  bool authResult = true;
  bool shouldThrow = false;

  @override
  Future<bool> deviceSupportsBiometrics() async => canCheck;

  @override
  Future<bool> isDeviceSupported() async => isSupported;

  @override
  Future<bool> authenticate({
    required String localizedReason,
    required Iterable<AuthMessages> authMessages,
    AuthenticationOptions options = const AuthenticationOptions(),
  }) async {
    if (shouldThrow) {
      throw Exception('Hardware failure');
    }
    return authResult;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeLocalAuthPlatform fakePlatform;
  late BiometricLockGatewayImpl gateway;

  setUp(() {
    fakePlatform = _FakeLocalAuthPlatform();
    LocalAuthPlatform.instance = fakePlatform;
    gateway = BiometricLockGatewayImpl();
  });

  group('BiometricLockGatewayImpl', () {
    test('checkDeviceSupported returns true when supported and can check', (
    ) async {
      fakePlatform
        ..canCheck = true
        ..isSupported = true;

      final result = await gateway.checkDeviceSupported();
      expect(result, isTrue);
    });

    test('checkDeviceSupported returns false when not supported', () async {
      fakePlatform
        ..canCheck = true
        ..isSupported = false;

      final result = await gateway.checkDeviceSupported();
      expect(result, isFalse);
    });

    test('authenticateUser returns true on successful challenge', () async {
      fakePlatform
        ..canCheck = true
        ..isSupported = true
        ..authResult = true;

      final result = await gateway.authenticateUser(
        localizedMessage: 'Scan finger',
      );
      expect(result, isTrue);
    });

    test('authenticateUser returns false when device is not supported', (
    ) async {
      fakePlatform.isSupported = false;

      final result = await gateway.authenticateUser(
        localizedMessage: 'Scan finger',
      );
      expect(result, isFalse);
    });

    test('authenticateUser throws AuthenticateUserFailed on error', () async {
      fakePlatform
        ..canCheck = true
        ..isSupported = true
        ..shouldThrow = true;

      expect(
        () => gateway.authenticateUser(localizedMessage: 'Scan finger'),
        throwsA(isA<AuthenticateUserFailed>()),
      );
    });
  });
}
