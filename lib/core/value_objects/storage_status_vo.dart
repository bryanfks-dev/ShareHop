import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_status_vo.freezed.dart';

@freezed
abstract class StorageStatusVO with _$StorageStatusVO {
  const factory({
    required double maximumCapacity,
    required double usedCapacity,
  }) = _StorageStatusVO;

  const new _();

  double get freeCapacity => maximumCapacity - usedCapacity;
}
