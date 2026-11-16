import 'package:sharehop/core/value_objects/storage_status_vo.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

class StorageStatusViewModel {
  new({
    required this.maximumCapacity,
    required this.usedCapacity,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory fromVO(
    StorageStatusVO vo, {
    DateTime? updatedAt,
  }) =>
      StorageStatusViewModel(
        maximumCapacity: vo.maximumCapacity,
        usedCapacity: vo.usedCapacity,
        updatedAt: updatedAt,
      );

  final double maximumCapacity;
  final double usedCapacity;
  DateTime updatedAt;

  double get freeCapacity => maximumCapacity - usedCapacity;

  double get usedPercentage {
    if (maximumCapacity <= 0) {
      return 0;
    }
    return (usedCapacity / maximumCapacity).clamp(0, 1);
  }

  int get totalBytes => maximumCapacity.toInt();
  int get usedBytes => usedCapacity.toInt();
  int get freeBytes => freeCapacity.toInt();

  static String formatBytes({required int bytes}) =>
      formatFileSize(bytes: bytes);
}
