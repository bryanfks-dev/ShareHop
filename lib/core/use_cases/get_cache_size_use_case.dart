import 'package:flutter/painting.dart';

class GetCacheSizeUseCase {
  const new();

  int call() => PaintingBinding.instance.imageCache.currentSizeBytes;
}
