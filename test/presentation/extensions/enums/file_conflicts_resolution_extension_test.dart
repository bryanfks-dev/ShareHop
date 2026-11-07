import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/presentation/extensions/enums/file_conflicts_resolution_extension.dart';

void main() {
  group('FileConflictsResolutionExtension', () {
    test('resolves labels correctly', () {
      expect(FileConflictsResolution.overwrite.label, 'Overwrite files');
      expect(FileConflictsResolution.skip.label, 'Skip files');
      expect(FileConflictsResolution.rename.label, 'Rename files');
      expect(FileConflictsResolution.askeverytime.label, 'Ask every time');
    });

    test('retains domain persistentValue', () {
      expect(FileConflictsResolution.overwrite.persistentValue, 'overwrite');
      expect(FileConflictsResolution.skip.persistentValue, 'skip');
      expect(FileConflictsResolution.rename.persistentValue, 'rename');
      expect(
        FileConflictsResolution.askeverytime.persistentValue,
        'ask_every_time',
      );
    });
  });
}
