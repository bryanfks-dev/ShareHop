import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:sharehop/core/security/secure_random.dart';

class SecureRandomImpl implements SecureRandom {
  new({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  @override
  Uint8List generateBytes({required int length}) {
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  @override
  String generateKey({int length = 32}) {
    final bytes = generateBytes(length: length);
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  @override
  String generateString({int length = 32}) {
    return generateKey(length: length);
  }
}
