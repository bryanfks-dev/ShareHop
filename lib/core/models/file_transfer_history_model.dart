import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/mixins/id_mixin.dart';
import 'package:sharehop/core/models/mixins/timestamp_mixin.dart';
import 'package:sharehop/core/models/persistence_model.dart';

part 'file_transfer_history_model.freezed.dart';
part 'file_transfer_history_model.g.dart';

@freezed
abstract class FileTransferHistoryModel
    with _$FileTransferHistoryModel, IdMixin, TimestampMixin
    implements PersistenceModel {
  const factory({
    required String id,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_size') required int fileSize,
    @JsonKey(name: 'file_mime_type') required String fileMimeType,
    @JsonKey(name: 'source_name') required String sourceName,
    @JsonKey(name: 'destination_name') required String destinationName,
    required FileTransferStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _FileTransferHistoryModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$FileTransferHistoryModelFromJson(json);

  static String get tableName => 'file_transfer_histories';
}
