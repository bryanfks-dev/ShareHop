import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/data/mapper/file_transfer_history_mapper.dart';
import 'package:uuid/uuid.dart';

void main() {
  const mapper = FileTransferHistoryMapper();
  final id = const Uuid().v4obj();
  final now = DateTime.utc(2026, 11, 15, 12);

  group('FileTransferHistoryMapper', () {
    test('converts row to model with persistent status value', () {
      final row = {
        'id': id.uuid,
        'file_name': 'test.png',
        'file_size': 2048,
        'file_mime_type': 'image/png',
        'source_name': 'iPhone',
        'destination_name': 'NAS',
        'status': 'in_progress',
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final model = mapper.toModel(row);
      expect(model.id, id);
      expect(model.fileName, 'test.png');
      expect(model.fileSize, 2048);
      expect(model.fileMimeType, 'image/png');
      expect(model.sourceName, 'iPhone');
      expect(model.destinationName, 'NAS');
      expect(model.status, FileTransferStatus.inProgress);
      expect(model.createdAt, now);
      expect(model.updatedAt, now);
    });

    test('converts row to model with camelCase status fallback', () {
      final row = {
        'id': id.uuid,
        'file_name': 'test.pdf',
        'file_size': 1024,
        'file_mime_type': 'application/pdf',
        'source_name': 'Local',
        'destination_name': 'Remote',
        'status': 'completed',
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final model = mapper.toModel(row);
      expect(model.status, FileTransferStatus.completed);
    });

    test('converts model to row correctly', () {
      final model = FileTransferHistoryModel(
        id: id,
        fileName: 'doc.txt',
        fileSize: 512,
        fileMimeType: 'text/plain',
        sourceName: 'Server',
        destinationName: 'Local',
        status: FileTransferStatus.inProgress,
        createdAt: now,
        updatedAt: now,
      );

      final row = mapper.toRow(model);
      expect(row['id'], id.uuid);
      expect(row['file_name'], 'doc.txt');
      expect(row['file_size'], 512);
      expect(row['status'], 'in_progress');
      expect(row['created_at'], now.toIso8601String());
    });
  });
}
