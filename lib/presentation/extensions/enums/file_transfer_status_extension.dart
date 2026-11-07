import 'package:sharehop/core/enums/file_transfer_status.dart';

extension FileTransferStatusExtension on FileTransferStatus {
  String get label {
    return switch (this) {
      FileTransferStatus.pending => 'Pending',
      FileTransferStatus.inProgress => 'In Progress',
      FileTransferStatus.completed => 'Completed',
      FileTransferStatus.failed => 'Failed',
      FileTransferStatus.canceled => 'Canceled',
    };
  }
}
