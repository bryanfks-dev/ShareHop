import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/presentation/extensions/enums/file_transfer_status_extension.dart';

void main() {
  group('FileTransferStatusExtension', () {
    test('resolves labels correctly', () {
      expect(FileTransferStatus.pending.label, 'Pending');
      expect(FileTransferStatus.inProgress.label, 'In Progress');
      expect(FileTransferStatus.completed.label, 'Completed');
      expect(FileTransferStatus.failed.label, 'Failed');
      expect(FileTransferStatus.canceled.label, 'Canceled');
    });

    test('retains domain persistentValue', () {
      expect(FileTransferStatus.pending.persistentValue, 'pending');
      expect(FileTransferStatus.inProgress.persistentValue, 'in_progress');
      expect(FileTransferStatus.completed.persistentValue, 'completed');
      expect(FileTransferStatus.failed.persistentValue, 'failed');
      expect(FileTransferStatus.canceled.persistentValue, 'canceled');
    });
  });
}
