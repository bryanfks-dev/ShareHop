import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/enums/file_category.dart';

void main() {
  group('FileCategory', () {
    test('contains all expected categories', () {
      expect(FileCategory.values, [
        FileCategory.image,
        FileCategory.video,
        FileCategory.audio,
        FileCategory.document,
        FileCategory.spreadsheet,
        FileCategory.archive,
        FileCategory.code,
        FileCategory.other,
      ]);
    });
  });
}
