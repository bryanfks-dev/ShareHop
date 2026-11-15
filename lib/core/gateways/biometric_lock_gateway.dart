abstract interface class BiometricLockGateway {
  Future<bool> checkDeviceSupported();
  Future<bool> authenticateUser({required String localizedMessage});
}
