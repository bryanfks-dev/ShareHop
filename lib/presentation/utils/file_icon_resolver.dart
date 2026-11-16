import 'package:flutter/widgets.dart';
import 'package:forui_lucide/forui_lucide.dart';

const _kImageExtensions = {
  'png',
  'jpg',
  'jpeg',
  'gif',
  'webp',
  'svg',
  'bmp',
  'ico',
  'tif',
  'tiff',
  'heic',
  'heif',
  'raw',
  'cr2',
  'nef',
  'ai',
  'psd',
  'eps',
};

const _kVideoExtensions = {
  'mp4',
  'mkv',
  'mov',
  'avi',
  'wmv',
  'flv',
  'webm',
  'm4v',
  '3gp',
  'mpg',
  'mpeg',
  'rm',
  'rmvb',
  'vob',
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
  'aiff',
  'alac',
  'mid',
  'midi',
};

const _kDocumentExtensions = {
  'txt',
  'md',
  'markdown',
  'pdf',
  'doc',
  'docx',
  'rtf',
  'log',
  'tex',
  'odt',
  'pages',
  'epub',
  'mobi',
};

const _kSpreadsheetExtensions = {
  'xls',
  'xlsx',
  'csv',
  'tsv',
  'ods',
  'numbers',
  'xlsm',
  'xlsb',
};

const _kArchiveExtensions = {
  'zip',
  'rar',
  '7z',
  'tar',
  'gz',
  'bz2',
  'xz',
  'tgz',
  'zst',
  'iso',
  'dmg',
  'apk',
  'aab',
  'pkg',
  'deb',
  'rpm',
};

const _kCodeExtensions = {
  'dart',
  'js',
  'mjs',
  'cjs',
  'jsx',
  'ts',
  'tsx',
  'html',
  'htm',
  'css',
  'scss',
  'sass',
  'less',
  'py',
  'pyw',
  'java',
  'kt',
  'kts',
  'c',
  'cpp',
  'cc',
  'cxx',
  'h',
  'hpp',
  'cs',
  'go',
  'rs',
  'rb',
  'php',
  'swift',
  'vue',
  'svelte',
  'scala',
  'lua',
  'r',
  'pl',
  'pm',
  'clj',
  'cljs',
  'ex',
  'exs',
  'erl',
  'hrl',
  'asm',
};

const _kJsonExtensions = {
  'json',
  'json5',
  'jsonc',
  'ndjson',
  'ipynb',
  'geojson',
};

const _kScriptExtensions = {
  'sh',
  'bash',
  'zsh',
  'fish',
  'bat',
  'cmd',
  'ps1',
  'psm1',
};

const _kConfigExtensions = {
  'yaml',
  'yml',
  'toml',
  'ini',
  'cfg',
  'conf',
  'env',
  'properties',
  'xml',
  'plist',
  'gitignore',
};

const _kKeyExtensions = {
  'key',
  'pem',
  'cer',
  'crt',
  'pub',
  'pfx',
  'p12',
  'der',
  'csr',
};

const _kDatabaseExtensions = {
  'db',
  'sqlite',
  'sqlite3',
  'sql',
  'mdb',
  'accdb',
};

const _kFontExtensions = {'ttf', 'otf', 'woff', 'woff2', 'eot'};

IconData resolveFileIcon({
  required String? fileNameOrExtension,
  IconData fallback = FLucideIcons.file,
}) {
  if (fileNameOrExtension == null) {
    return fallback;
  }

  final ext = _extractExtension(input: fileNameOrExtension);
  if (ext.isEmpty) {
    return fallback;
  }

  if (_kImageExtensions.contains(ext)) {
    return FLucideIcons.fileImage;
  }
  if (_kVideoExtensions.contains(ext)) {
    return FLucideIcons.fileVideo;
  }
  if (_kAudioExtensions.contains(ext)) {
    return FLucideIcons.fileMusic;
  }
  if (_kDocumentExtensions.contains(ext)) {
    return FLucideIcons.fileText;
  }
  if (_kSpreadsheetExtensions.contains(ext)) {
    return FLucideIcons.fileSpreadsheet;
  }
  if (_kArchiveExtensions.contains(ext)) {
    return FLucideIcons.fileArchive;
  }
  if (_kCodeExtensions.contains(ext)) {
    return FLucideIcons.fileCode;
  }
  if (_kJsonExtensions.contains(ext)) {
    return FLucideIcons.fileJson;
  }
  if (_kScriptExtensions.contains(ext)) {
    return FLucideIcons.fileTerminal;
  }
  if (_kConfigExtensions.contains(ext)) {
    return FLucideIcons.fileSliders;
  }
  if (_kKeyExtensions.contains(ext)) {
    return FLucideIcons.fileKey;
  }
  if (_kDatabaseExtensions.contains(ext)) {
    return FLucideIcons.database;
  }
  if (_kFontExtensions.contains(ext)) {
    return FLucideIcons.fileType;
  }
  if (ext == 'lock') {
    return FLucideIcons.fileLock;
  }

  return fallback;
}

IconData resolveFileIconFromExtension({
  required String? extension,
  IconData fallback = FLucideIcons.file,
}) => resolveFileIcon(fileNameOrExtension: extension, fallback: fallback);

extension FileIconResolverExtension on String {
  IconData get fileIcon => resolveFileIcon(fileNameOrExtension: this);
}

String _extractExtension({required String input}) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    return '';
  }

  final fileName = trimmed.split(RegExp(r'[/\\]')).last;
  if (fileName.isEmpty) {
    return '';
  }

  final dotIndex = fileName.lastIndexOf('.');
  if (dotIndex == -1) {
    return fileName.toLowerCase();
  }

  if (dotIndex == 0) {
    return fileName.substring(1).toLowerCase();
  }

  return fileName.substring(dotIndex + 1).toLowerCase();
}
