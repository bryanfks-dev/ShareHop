import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/security/secure_random.dart';
import 'package:sharehop/infrastructures/security/secure_random_impl.dart';

void main() {
  group('SecureRandomImpl', () {
    test('implements SecureRandom interface', () {
      const SecureRandom secureRandom = SecureRandomImpl();
      expect(secureRandom, isA<SecureRandom>());
    });

    test('generateKey generates non-empty string without padding', () {
      const secureRandom = SecureRandomImpl();
      final key = secureRandom.generateKey();

      expect(key, isNotEmpty);
      expect(key.contains('='), isFalse);
    });

    test('generateKey generates unique keys across multiple invocations', () {
      const secureRandom = SecureRandomImpl();
      final keys = List.generate(20, (_) => secureRandom.generateKey());
      final uniqueKeys = keys.toSet();

      expect(uniqueKeys.length, equals(keys.length));
    });

    test('generateString behaves consistently with key generation', () {
      const secureRandom = SecureRandomImpl();
      final str1 = secureRandom.generateString();
      final str2 = secureRandom.generateString();

      expect(str1, isNotEmpty);
      expect(str2, isNotEmpty);
      expect(str1, isNot(equals(str2)));
    });

    test('generateBytes generates requested number of random bytes', () {
      const secureRandom = SecureRandomImpl();
      final bytes16 = secureRandom.generateBytes(length: 16);
      final bytes32 = secureRandom.generateBytes(length: 32);

      expect(bytes16.length, equals(16));
      expect(bytes32.length, equals(32));
    });

    test('generateBytes generates unique byte sequences', () {
      const secureRandom = SecureRandomImpl();
      final bytes1 = secureRandom.generateBytes(length: 32);
      final bytes2 = secureRandom.generateBytes(length: 32);

      expect(bytes1, isNot(equals(bytes2)));
    });

    test('accepts custom Random for deterministic testing', () {
      final deterministicRandom1 = Random(42);
      final deterministicRandom2 = Random(42);

      final secureRandom1 = SecureRandomImpl(random: deterministicRandom1);
      final secureRandom2 = SecureRandomImpl(random: deterministicRandom2);

      expect(
        secureRandom1.generateBytes(length: 16),
        equals(secureRandom2.generateBytes(length: 16)),
      );
    });
  });
}
