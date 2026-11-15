import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';
import 'package:sharehop/core/use_cases/authenticate_biometric_lock_use_case.dart';
import 'package:sharehop/core/use_cases/check_device_biometric_supported_use_case.dart';

class _FakeBiometricLockGateway implements BiometricLockGateway {
  new();

  bool isSupported = true;
  bool authenticateResult = true;
  String? lastLocalizedMessage;

  @override
  Future<bool> checkDeviceSupported() async => isSupported;

  @override
  Future<bool> authenticateUser({required String localizedMessage}) async {
    lastLocalizedMessage = localizedMessage;
    return authenticateResult;
  }
}

void main() {
  group('BiometricLockUseCases', () {
    test(
      'CheckDeviceBiometricSupportedUseCase returns gateway result',
      () async {
        final gateway = _FakeBiometricLockGateway();
        final useCase = CheckDeviceBiometricSupportedUseCase(
          biometricLockGateway: gateway,
        );

        expect(await useCase(), isTrue);

        gateway.isSupported = false;
        expect(await useCase(), isFalse);
      },
    );

    test('AuthenticateBiometricLockUseCase forwards call to gateway', () async {
      final gateway = _FakeBiometricLockGateway();
      final useCase = AuthenticateBiometricLockUseCase(
        biometricLockGateway: gateway,
      );

      final result = await useCase(localizedMessage: 'Test auth');
      expect(result, isTrue);
      expect(gateway.lastLocalizedMessage, 'Test auth');

      gateway.authenticateResult = false;
      expect(await useCase(localizedMessage: 'Retry'), isFalse);
      expect(gateway.lastLocalizedMessage, 'Retry');
    });
  });
}
