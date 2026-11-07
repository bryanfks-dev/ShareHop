import 'dart:typed_data';

abstract interface class SecureRandom {
  Uint8List generateBytes({required int length});
  String generateKey({int length = 32});
  String generateString({int length = 32});
}
