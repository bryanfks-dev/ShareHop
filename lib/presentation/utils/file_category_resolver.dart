import 'dart:ui';

import 'package:forui/forui.dart';
import 'package:sharehop/presentation/enums/file_category.dart';
import 'package:sharehop/presentation/theme/theme.dart';

const _kImageExtensions = {
  'png',
  'jpg',
  'jpeg',
  'gif',
  'webp',
  'svg',
  'heic',
  'heif',
  'bmp',
  'ico',
  'tiff',
  'raw',
};

const _kVideoExtensions = {
  'mp4',
  'mkv',
  'mov',
  'avi',
  'webm',
  'm4v',
  '3gp',
  'flv',
};

const _kAudioExtensions = {
  'mp3',
  'wav',
  'flac',
  'aac',
  'ogg',
  'm4a',
  'wma',
  'opus',
};

const _kDocumentExtensions = {
  'pdf',
  'doc',
  'docx',
  'txt',
  'rtf',
  'odt',
  'pages',
  'epub',
};

const _kSpreadsheetExtensions = {'xls', 'xlsx', 'csv', 'tsv', 'ods', 'numbers'};

const _kArchiveExtensions = {
  'zip',
  'rar',
  '7z',
  'tar',
  'gz',
  'bz2',
  'xz',
  'apk',
  'dmg',
  'pkg',
};

const _kCodeExtensions = {
  'dart',
  'js',
  'ts',
  'jsx',
  'tsx',
  'html',
  'css',
  'json',
  'yaml',
  'yml',
  'py',
  'java',
  'kt',
  'c',
  'cpp',
  'rs',
  'go',
  'sh',
  'sql',
};

FileCategory resolveFileCategory({
  required String fileName,
  String mimeType = '',
}) {
  final lowerMime = mimeType.toLowerCase();
  if (lowerMime.startsWith('image/')) {
    return FileCategory.image;
  }
  if (lowerMime.startsWith('video/')) {
    return FileCategory.video;
  }
  if (lowerMime.startsWith('audio/')) {
    return FileCategory.audio;
  }

  final ext = extractFileExtension(fileName: fileName);
  if (_kImageExtensions.contains(ext)) {
    return FileCategory.image;
  }
  if (_kVideoExtensions.contains(ext)) {
    return FileCategory.video;
  }
  if (_kAudioExtensions.contains(ext)) {
    return FileCategory.audio;
  }
  if (_kDocumentExtensions.contains(ext)) {
    return FileCategory.document;
  }
  if (_kSpreadsheetExtensions.contains(ext)) {
    return FileCategory.spreadsheet;
  }
  if (_kArchiveExtensions.contains(ext)) {
    return FileCategory.archive;
  }
  if (_kCodeExtensions.contains(ext)) {
    return FileCategory.code;
  }
  return FileCategory.other;
}

Color resolveCategoryColor({
  required FileCategory category,
  required FThemeData theme,
}) {
  return switch (category) {
    FileCategory.image => theme.colors.app.accentBlue,
    FileCategory.video => theme.colors.app.accentPurple,
    FileCategory.audio => theme.colors.app.accentOrange,
    FileCategory.document => theme.colors.app.accentRed,
    FileCategory.spreadsheet => theme.colors.app.accentGreen,
    FileCategory.archive => theme.colors.app.accentOrange,
    FileCategory.code => theme.colors.app.accentTeal,
    FileCategory.other => theme.colors.app.accentBlue,
  };
}

String extractFileExtension({required String fileName}) {
  final trimmed = fileName.trim();
  if (trimmed.isEmpty) {
    return '';
  }
  final name = trimmed.split(RegExp(r'[/\\]')).last;
  final dotIndex = name.lastIndexOf('.');
  if (dotIndex == -1 || dotIndex == 0 || dotIndex == name.length - 1) {
    return '';
  }
  return name.substring(dotIndex + 1).toLowerCase();
}
