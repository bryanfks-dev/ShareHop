class StorageStatusDto {
  const new({
    required this.totalBytes,
    required this.freeBytes,
    this.updatedAt,
  });

  final int totalBytes;
  final int freeBytes;
  final DateTime? updatedAt;

  int get usedBytes => totalBytes > freeBytes ? totalBytes - freeBytes : 0;

  double get usedPercentage {
    if (totalBytes <= 0) {
      return 0;
    }
    return (usedBytes / totalBytes).clamp(0, 1);
  }

  static String formatBytes({required int bytes}) {
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var i = 0;
    var value = bytes.toDouble();
    while (value >= 1024 && i < suffixes.length - 1) {
      value /= 1024;
      i++;
    }
    final formatted = value.toStringAsFixed(value < 10 && i > 0 ? 1 : 0);
    return '$formatted ${suffixes[i]}';
  }
}
