String formatFileSize({required int bytes}) {
  if (bytes <= 0) {
    return '0 B';
  }
  const kSuffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
  var i = 0;
  var size = bytes.toDouble();
  while (size >= 1024 && i < kSuffixes.length - 1) {
    size /= 1024;
    i++;
  }
  final formatted = size.toStringAsFixed(size >= 10 || i == 0 ? 0 : 1);
  return '$formatted ${kSuffixes[i]}';
}
