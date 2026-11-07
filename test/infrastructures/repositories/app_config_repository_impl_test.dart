import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
// Transitive dependency needed for mocking SharedPreferencesAsync in tests.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
// Transitive dependency needed for mocking SharedPreferencesAsync in tests.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sharehop/core/security/secure_random.dart';
import 'package:sharehop/infrastructures/repositories/app_config_repository_impl.dart';

class FakeFlutterSecureStorage extends FlutterSecureStorage {
  new([Map<String, String>? initialData])
    : _storage = initialData ?? <String, String>{};

  final Map<String, String> _storage;
  int writeCount = 0;
  int readCount = 0;

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    readCount++;
    return _storage[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    writeCount++;
    if (value == null) {
      _storage.remove(key);
    } else {
      _storage[key] = value;
    }
  }

  @override
  Future<bool> containsKey({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _storage.containsKey(key);
  }
}

class FakeSecureRandom implements SecureRandom {
  const new({this.generatedKey = 'custom-generated-key'});

  final String generatedKey;

  @override
  String generateKey({int length = 32}) => generatedKey;

  @override
  String generateString({int length = 32}) => generatedKey;

  @override
  Uint8List generateBytes({required int length}) => Uint8List(length);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  group('AppConfigRepositoryImpl getEncryptionKey', () {
    test('generates and stores key on first retrieval', () async {
      final fakeStorage = FakeFlutterSecureStorage();
      final repository = AppConfigRepositoryImpl(secureStorage: fakeStorage);

      final key = await repository.getEncryptionKey();

      expect(key, isNotEmpty);
      expect(fakeStorage.writeCount, equals(1));
      expect(fakeStorage._storage['encryption_key'], equals(key));
    });

    test('uses injected SecureRandom to generate encryption key', () async {
      final fakeStorage = FakeFlutterSecureStorage();
      const fakeRandom = FakeSecureRandom(
        generatedKey: 'mocked-device-unique-key',
      );
      final repository = AppConfigRepositoryImpl(
        secureStorage: fakeStorage,
        secureRandom: fakeRandom,
      );

      final key = await repository.getEncryptionKey();

      expect(key, equals('mocked-device-unique-key'));
      expect(
        fakeStorage._storage['encryption_key'],
        equals('mocked-device-unique-key'),
      );
    });

    test(
      'returns existing key and does not overwrite on subsequent retrievals',
      () async {
        final fakeStorage = FakeFlutterSecureStorage({
          'encryption_key': 'existing-secure-encryption-key',
        });
        final repository = AppConfigRepositoryImpl(secureStorage: fakeStorage);

        final firstCallKey = await repository.getEncryptionKey();
        final secondCallKey = await repository.getEncryptionKey();

        expect(firstCallKey, equals('existing-secure-encryption-key'));
        expect(secondCallKey, equals('existing-secure-encryption-key'));
        expect(fakeStorage.writeCount, equals(0));
      },
    );

    test(
      'concurrent calls during initial retrieval do not overwrite each other',
      () async {
        final fakeStorage = FakeFlutterSecureStorage();
        final repository = AppConfigRepositoryImpl(secureStorage: fakeStorage);

        final results = await Future.wait([
          repository.getEncryptionKey(),
          repository.getEncryptionKey(),
          repository.getEncryptionKey(),
        ]);

        expect(results[0], isNotEmpty);
        expect(results[1], equals(results[0]));
        expect(results[2], equals(results[0]));
        expect(fakeStorage.writeCount, equals(1));
      },
    );

    test('getConfig triggers getEncryptionKey on initial app open', () async {
      final fakeStorage = FakeFlutterSecureStorage();
      final repository = AppConfigRepositoryImpl(secureStorage: fakeStorage);

      final config = await repository.getConfig();

      expect(config, isNotNull);
      expect(fakeStorage.writeCount, equals(1));
      expect(fakeStorage._storage['encryption_key'], isNotEmpty);

      // Subsequent call does not overwrite
      final config2 = await repository.getConfig();
      expect(config2, isNotNull);
      expect(fakeStorage.writeCount, equals(1));
    });
  });
}
