String formatFileSize({required int bytes}) {
  if (bytes <= 0) {
    return '0 B';
  }
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
  var i = 0;
  var size = bytes.toDouble();
  while (size >= 1024 && i < suffixes.length - 1) {
    size /= 1024;
    i++;
  }
  return '${size.toStringAsFixed(size >= 10 || i == 0 ? 0 : 1)} ${suffixes[i]}';
}
