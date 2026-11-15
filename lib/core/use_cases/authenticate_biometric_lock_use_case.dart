import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';

class AuthenticateBiometricLockUseCase {
  const new({required this.biometricLockGateway});

  final BiometricLockGateway biometricLockGateway;

  Future<bool> call({required String localizedMessage}) =>
      biometricLockGateway.authenticateUser(localizedMessage: localizedMessage);
}
