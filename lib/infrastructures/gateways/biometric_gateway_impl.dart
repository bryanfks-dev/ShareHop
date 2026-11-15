import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import 'package:sharehop/core/errors/auth.dart';
import 'package:sharehop/core/gateways/biometric_lock_gateway.dart';

class BiometricLockGatewayImpl implements BiometricLockGateway {
  final _authentication = LocalAuthentication();

  @override
  Future<bool> checkDeviceSupported() async {
    final canAuthenticateWithBiometrics =
        await _authentication.canCheckBiometrics;
    final deviceSupported = await _authentication.isDeviceSupported();
    return canAuthenticateWithBiometrics && deviceSupported;
  }

  @override
  Future<bool> authenticateUser({required String localizedMessage}) async {
    log(
      'Authenticate user started',
      name: 'BiometricLockGatewayImpl.authenticateUser',
    );

    try {
      if (!await checkDeviceSupported()) {
        return false;
      }

      return await _authentication.authenticate(
        localizedReason: localizedMessage,
        biometricOnly: true,
      );
    } on Exception catch (e, st) {
      log(
        'Authenticate user failed',
        name: 'BiometricLockGatewayImpl.authenticateUser',
        error: e,
        stackTrace: st,
      );
      throw AuthenticateUserFailed();
    }
  }
}
