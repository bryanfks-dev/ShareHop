import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/use_cases/clear_cache_use_case.dart';
import 'package:sharehop/core/use_cases/get_cache_size_use_case.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ClearCacheUseCase and GetCacheSizeUseCase', () {
    test('GetCacheSizeUseCase returns current size in bytes', () {
      const getCacheSize = GetCacheSizeUseCase();
      final size = getCacheSize.call();
      expect(size, isA<int>());
      expect(size >= 0, isTrue);
    });

    test('ClearCacheUseCase executes without error', () async {
      const clearCache = ClearCacheUseCase();
      await expectLater(clearCache.call(), completes);
    });
  });
}
