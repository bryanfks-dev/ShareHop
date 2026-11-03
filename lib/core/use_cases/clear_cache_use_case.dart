import 'package:flutter/painting.dart';

class ClearCacheUseCase {
  const new();

  Future<void> call() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
