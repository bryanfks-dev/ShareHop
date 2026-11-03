import 'package:flutter/widgets.dart';
import 'package:forui_lucide/forui_lucide.dart';

const _imageExtensions = {
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

const _videoExtensions = {
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

const _audioExtensions = {
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

const _documentExtensions = {
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

const _spreadsheetExtensions = {
  'xls',
  'xlsx',
  'csv',
  'tsv',
  'ods',
  'numbers',
  'xlsm',
  'xlsb',
};

const _archiveExtensions = {
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

const _codeExtensions = {
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

const _jsonExtensions = {
  'json',
  'json5',
  'jsonc',
  'ndjson',
  'ipynb',
  'geojson',
};

const _scriptExtensions = {
  'sh',
  'bash',
  'zsh',
  'fish',
  'bat',
  'cmd',
  'ps1',
  'psm1',
};

const _configExtensions = {
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

const _keyExtensions = {
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

const _databaseExtensions = {'db', 'sqlite', 'sqlite3', 'sql', 'mdb', 'accdb'};

const _fontExtensions = {'ttf', 'otf', 'woff', 'woff2', 'eot'};

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

  if (_imageExtensions.contains(ext)) {
    return FLucideIcons.fileImage;
  }
  if (_videoExtensions.contains(ext)) {
    return FLucideIcons.fileVideo;
  }
  if (_audioExtensions.contains(ext)) {
    return FLucideIcons.fileMusic;
  }
  if (_documentExtensions.contains(ext)) {
    return FLucideIcons.fileText;
  }
  if (_spreadsheetExtensions.contains(ext)) {
    return FLucideIcons.fileSpreadsheet;
  }
  if (_archiveExtensions.contains(ext)) {
    return FLucideIcons.fileArchive;
  }
  if (_codeExtensions.contains(ext)) {
    return FLucideIcons.fileCode;
  }
  if (_jsonExtensions.contains(ext)) {
    return FLucideIcons.fileJson;
  }
  if (_scriptExtensions.contains(ext)) {
    return FLucideIcons.fileTerminal;
  }
  if (_configExtensions.contains(ext)) {
    return FLucideIcons.fileSliders;
  }
  if (_keyExtensions.contains(ext)) {
    return FLucideIcons.fileKey;
  }
  if (_databaseExtensions.contains(ext)) {
    return FLucideIcons.database;
  }
  if (_fontExtensions.contains(ext)) {
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
