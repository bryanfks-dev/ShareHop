import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/converters/uuid_value_converter.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';
import 'package:uuid/uuid_value.dart';

part 'file_transfer_history_model.freezed.dart';
part 'file_transfer_history_model.g.dart';

@freezed
abstract class FileTransferHistoryModel
    with _$FileTransferHistoryModel, IdMixin, TimestampMixin
    implements PersistenceModel {
  const factory({
    @UuidValueConverter() required UuidValue id,
    required String fileName,
    required int fileSize,
    required String fileMimeType,
    required String sourceName,
    required String destinationName,
    required FileTransferStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FileTransferHistoryModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$FileTransferHistoryModelFromJson(json);

  static String get tableName => 'file_transfer_histories';
}
