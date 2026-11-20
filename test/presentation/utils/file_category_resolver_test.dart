import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/enums/file_category.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/utils/file_category_resolver.dart';

void main() {
  group('extractFileExtension', () {
    test('extracts file extension in lowercase', () {
      expect(extractFileExtension(fileName: 'photo.JPG'), 'jpg');
      expect(extractFileExtension(fileName: 'document.pdf'), 'pdf');
      expect(extractFileExtension(fileName: 'archive.tar.gz'), 'gz');
      expect(extractFileExtension(fileName: '/path/to/my_file.PNG'), 'png');
      expect(extractFileExtension(fileName: r'C:\Users\docs\sheet.XLSX'), 'xlsx');
    });

    test('returns empty string for files without extension or edge cases', () {
      expect(extractFileExtension(fileName: ''), '');
      expect(extractFileExtension(fileName: '   '), '');
      expect(extractFileExtension(fileName: 'no_extension'), '');
      expect(extractFileExtension(fileName: '.gitignore'), '');
      expect(extractFileExtension(fileName: 'trailing_dot.'), '');
    });
  });

  group('resolveFileCategory', () {
    test('resolves category from mimeType when provided', () {
      expect(
        resolveFileCategory(fileName: 'unknown', mimeType: 'image/png'),
        FileCategory.image,
      );
      expect(
        resolveFileCategory(fileName: 'unknown', mimeType: 'video/mp4'),
        FileCategory.video,
      );
      expect(
        resolveFileCategory(fileName: 'unknown', mimeType: 'audio/mpeg'),
        FileCategory.audio,
      );
    });

    test('resolves image category from extensions', () {
      const exts = [
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
      ];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.image,
          reason: 'Extension $ext should be image',
        );
      }
    });

    test('resolves video category from extensions', () {
      const exts = ['mp4', 'mkv', 'mov', 'avi', 'webm', 'm4v', '3gp', 'flv'];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.video,
          reason: 'Extension $ext should be video',
        );
      }
    });

    test('resolves audio category from extensions', () {
      const exts = ['mp3', 'wav', 'flac', 'aac', 'ogg', 'm4a', 'wma', 'opus'];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.audio,
          reason: 'Extension $ext should be audio',
        );
      }
    });

    test('resolves document category from extensions', () {
      const exts = [
        'pdf',
        'doc',
        'docx',
        'txt',
        'rtf',
        'odt',
        'pages',
        'epub',
      ];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.document,
          reason: 'Extension $ext should be document',
        );
      }
    });

    test('resolves spreadsheet category from extensions', () {
      const exts = ['xls', 'xlsx', 'csv', 'tsv', 'ods', 'numbers'];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.spreadsheet,
          reason: 'Extension $ext should be spreadsheet',
        );
      }
    });

    test('resolves archive category from extensions', () {
      const exts = [
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
      ];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.archive,
          reason: 'Extension $ext should be archive',
        );
      }
    });

    test('resolves code category from extensions', () {
      const exts = [
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
      ];
      for (final ext in exts) {
        expect(
          resolveFileCategory(fileName: 'test.$ext'),
          FileCategory.code,
          reason: 'Extension $ext should be code',
        );
      }
    });

    test('falls back to other category for unrecognized extensions', () {
      expect(resolveFileCategory(fileName: 'file.xyz'), FileCategory.other);
      expect(resolveFileCategory(fileName: 'unknown_file'), FileCategory.other);
    });
  });

  group('resolveCategoryColor', () {
    test('returns theme accent colors for each category', () {
      final theme = lightTheme;

      expect(
        resolveCategoryColor(category: FileCategory.image, theme: theme),
        theme.colors.app.accentBlue,
      );
      expect(
        resolveCategoryColor(category: FileCategory.video, theme: theme),
        theme.colors.app.accentPurple,
      );
      expect(
        resolveCategoryColor(category: FileCategory.audio, theme: theme),
        theme.colors.app.accentOrange,
      );
      expect(
        resolveCategoryColor(category: FileCategory.document, theme: theme),
        theme.colors.app.accentRed,
      );
      expect(
        resolveCategoryColor(category: FileCategory.spreadsheet, theme: theme),
        theme.colors.app.accentGreen,
      );
      expect(
        resolveCategoryColor(category: FileCategory.archive, theme: theme),
        theme.colors.app.accentOrange,
      );
      expect(
        resolveCategoryColor(category: FileCategory.code, theme: theme),
        theme.colors.app.accentTeal,
      );
      expect(
        resolveCategoryColor(category: FileCategory.other, theme: theme),
        theme.colors.app.accentBlue,
      );
    });
  });
}
