import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';

void main() {
  group('FileTransferStatus', () {
    test('contains expected enum values and persistentValues', () {
      expect(FileTransferStatus.values, [
        FileTransferStatus.pending,
        FileTransferStatus.inProgress,
        FileTransferStatus.completed,
        FileTransferStatus.failed,
        FileTransferStatus.canceled,
      ]);

      expect(FileTransferStatus.pending.persistentValue, 'pending');
      expect(FileTransferStatus.inProgress.persistentValue, 'in_progress');
      expect(FileTransferStatus.completed.persistentValue, 'completed');
      expect(FileTransferStatus.failed.persistentValue, 'failed');
      expect(FileTransferStatus.canceled.persistentValue, 'canceled');
    });
  });
}
