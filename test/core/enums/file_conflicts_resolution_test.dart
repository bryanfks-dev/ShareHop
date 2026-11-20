import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';

void main() {
  group('FileConflictsResolution', () {
    test('contains expected enum values and persistentValues', () {
      expect(FileConflictsResolution.values, [
        FileConflictsResolution.overwrite,
        FileConflictsResolution.skip,
        FileConflictsResolution.rename,
        FileConflictsResolution.askeverytime,
      ]);

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
