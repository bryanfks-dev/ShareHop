abstract interface class BiometricLockService {
  Future<bool> checkDeviceSupported();
  Future<bool> authenticateUser({required String localizedMessage});
}
