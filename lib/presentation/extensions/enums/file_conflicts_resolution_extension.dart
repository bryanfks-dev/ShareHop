import 'package:sharehop/core/enums/file_conflicts_resolution.dart';

extension FileConflictsResolutionExtension on FileConflictsResolution {
  String get label {
    return switch (this) {
      FileConflictsResolution.overwrite => 'Overwrite files',
      FileConflictsResolution.skip => 'Skip files',
      FileConflictsResolution.rename => 'Rename files',
      FileConflictsResolution.askeverytime => 'Ask every time',
    };
  }
}
