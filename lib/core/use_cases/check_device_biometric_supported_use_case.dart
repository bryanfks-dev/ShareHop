import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';

class CheckDeviceBiometricSupportedUseCase {
  const new({required this.biometricLockGateway});

  final BiometricLockGateway biometricLockGateway;

  Future<bool> call() => biometricLockGateway.checkDeviceSupported();
}
