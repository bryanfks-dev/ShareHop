import 'package:flutter_test/flutter_test.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';

void main() {
  group('resolveFileIcon', () {
    test('resolves image extensions to fileImage', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'png'),
        equals(FLucideIcons.fileImage),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.jpg'),
        equals(FLucideIcons.fileImage),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'image.JPEG'),
        equals(FLucideIcons.fileImage),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'path/to/photo.webp'),
        equals(FLucideIcons.fileImage),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'icon.svg'),
        equals(FLucideIcons.fileImage),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'design.psd'),
        equals(FLucideIcons.fileImage),
      );
    });

    test('resolves audio extensions to fileMusic', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'mp3'),
        equals(FLucideIcons.fileMusic),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.wav'),
        equals(FLucideIcons.fileMusic),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'song.flac'),
        equals(FLucideIcons.fileMusic),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'audio.m4a'),
        equals(FLucideIcons.fileMusic),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'track.ogg'),
        equals(FLucideIcons.fileMusic),
      );
    });

    test('resolves video extensions to fileVideo', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'mp4'),
        equals(FLucideIcons.fileVideo),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.mkv'),
        equals(FLucideIcons.fileVideo),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'movie.MOV'),
        equals(FLucideIcons.fileVideo),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'video.webm'),
        equals(FLucideIcons.fileVideo),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'clip.avi'),
        equals(FLucideIcons.fileVideo),
      );
    });

    test('resolves documents and text extensions to fileText', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'pdf'),
        equals(FLucideIcons.fileText),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'readme.md'),
        equals(FLucideIcons.fileText),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.txt'),
        equals(FLucideIcons.fileText),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'doc.docx'),
        equals(FLucideIcons.fileText),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'paper.tex'),
        equals(FLucideIcons.fileText),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'system.log'),
        equals(FLucideIcons.fileText),
      );
    });

    test('resolves spreadsheets to fileSpreadsheet', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'xlsx'),
        equals(FLucideIcons.fileSpreadsheet),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.xls'),
        equals(FLucideIcons.fileSpreadsheet),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'data.csv'),
        equals(FLucideIcons.fileSpreadsheet),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'export.tsv'),
        equals(FLucideIcons.fileSpreadsheet),
      );
    });

    test('resolves archives to fileArchive', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'zip'),
        equals(FLucideIcons.fileArchive),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.tar.gz'),
        equals(FLucideIcons.fileArchive),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'archive.7z'),
        equals(FLucideIcons.fileArchive),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'package.tar'),
        equals(FLucideIcons.fileArchive),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'app.apk'),
        equals(FLucideIcons.fileArchive),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'installer.dmg'),
        equals(FLucideIcons.fileArchive),
      );
    });

    test('resolves code to fileCode', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'dart'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.js'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'index.ts'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'app.tsx'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'main.py'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'native.cpp'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'style.css'),
        equals(FLucideIcons.fileCode),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'page.html'),
        equals(FLucideIcons.fileCode),
      );
    });

    test('resolves json to fileJson', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'json'),
        equals(FLucideIcons.fileJson),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.json5'),
        equals(FLucideIcons.fileJson),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'notebook.ipynb'),
        equals(FLucideIcons.fileJson),
      );
    });

    test('resolves terminal and shell scripts to fileTerminal', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'sh'),
        equals(FLucideIcons.fileTerminal),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'build.bash'),
        equals(FLucideIcons.fileTerminal),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'run.bat'),
        equals(FLucideIcons.fileTerminal),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'deploy.ps1'),
        equals(FLucideIcons.fileTerminal),
      );
    });

    test('resolves configs and properties to fileSliders', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'yaml'),
        equals(FLucideIcons.fileSliders),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.yml'),
        equals(FLucideIcons.fileSliders),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'config.toml'),
        equals(FLucideIcons.fileSliders),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.env'),
        equals(FLucideIcons.fileSliders),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '.gitignore'),
        equals(FLucideIcons.fileSliders),
      );
    });

    test('resolves keys and certificates to fileKey', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'key'),
        equals(FLucideIcons.fileKey),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'cert.pem'),
        equals(FLucideIcons.fileKey),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'ssl.crt'),
        equals(FLucideIcons.fileKey),
      );
    });

    test('resolves databases to database', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'db'),
        equals(FLucideIcons.database),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'app.sqlite'),
        equals(FLucideIcons.database),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'schema.sql'),
        equals(FLucideIcons.database),
      );
    });

    test('resolves fonts to fileType', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'ttf'),
        equals(FLucideIcons.fileType),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'font.woff2'),
        equals(FLucideIcons.fileType),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'custom.otf'),
        equals(FLucideIcons.fileType),
      );
    });

    test('resolves lock files to fileLock', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'lock'),
        equals(FLucideIcons.fileLock),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'pubspec.lock'),
        equals(FLucideIcons.fileLock),
      );
    });

    test('falls back to default file icon for unknown extensions', () {
      expect(
        resolveFileIcon(fileNameOrExtension: 'unknown_file_type.xyz123'),
        equals(FLucideIcons.file),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: 'noextension'),
        equals(FLucideIcons.file),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: null),
        equals(FLucideIcons.file),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: ''),
        equals(FLucideIcons.file),
      );
      expect(
        resolveFileIcon(fileNameOrExtension: '   '),
        equals(FLucideIcons.file),
      );
    });

    test('supports custom fallback icon', () {
      expect(
        resolveFileIcon(
          fileNameOrExtension: 'unknown.xyz',
          fallback: FLucideIcons.fileWarning,
        ),
        equals(FLucideIcons.fileWarning),
      );
      expect(
        resolveFileIcon(
          fileNameOrExtension: null,
          fallback: FLucideIcons.fileWarning,
        ),
        equals(FLucideIcons.fileWarning),
      );
    });
  });

  group('resolveFileIconFromExtension', () {
    test('works with extension without dot', () {
      expect(
        resolveFileIconFromExtension(extension: 'png'),
        equals(FLucideIcons.fileImage),
      );
    });

    test('works with extension with dot', () {
      expect(
        resolveFileIconFromExtension(extension: '.mp4'),
        equals(FLucideIcons.fileVideo),
      );
    });
  });

  group('FileIconResolverExtension', () {
    test('fileIcon getter works on String', () {
      expect(
        FileIconResolverExtension('sample.pdf').fileIcon,
        equals(FLucideIcons.fileText),
      );
      expect(
        FileIconResolverExtension('song.mp3').fileIcon,
        equals(FLucideIcons.fileMusic),
      );
    });
  });
}
