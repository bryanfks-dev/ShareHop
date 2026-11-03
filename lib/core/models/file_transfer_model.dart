import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/base_model.dart';

part 'file_transfer_model.freezed.dart';
part 'file_transfer_model.g.dart';

@freezed
abstract class FileTransferModel with _$FileTransferModel implements BaseModel {
  const factory({
    required String id,
    required String fileName,
    @JsonKey(name: 'file_size') required int fileSize,
    @JsonKey(name: 'file_mime_type') required String fileMimeType,
    @JsonKey(name: 'source_name') required String sourceName,
    @JsonKey(name: 'destination_name') required String destinationName,
    required FileTransferStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _FileTransferModel;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$FileTransferModelFromJson(json);

  static String get tableName => 'file_transfer_histories';

  DateTime get transferDateTime => createdAt;
}
