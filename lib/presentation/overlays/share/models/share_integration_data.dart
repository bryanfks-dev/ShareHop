import 'package:flutter/foundation.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

/// Representation of an individual file to share.
@immutable
class SharedFileInfo {
  const new({
    required this.name,
    this.size = 0,
    this.mimeType = '',
    this.uri = '',
  });

  final String name;
  final int size;
  final String mimeType;
  final String uri;

  String get formattedSize => formatFileSize(bytes: size);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SharedFileInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          size == other.size &&
          uri == other.uri;

  @override
  int get hashCode => name.hashCode ^ size.hashCode ^ uri.hashCode;
}

/// Mock data representation for items to share.
@immutable
class ShareIntegrationItem {
  const new({
    this.title = 'Campaign selects',
    this.subtitle = '3 JPEG images',
    this.fileCount = 3,
    this.totalSize = '24.8 MB',
    this.files = const [
      SharedFileInfo(
        name: 'IMG_4021.jpg',
        size: 8700000,
        mimeType: 'image/jpeg',
      ),
      SharedFileInfo(
        name: 'IMG_4022.jpg',
        size: 8100000,
        mimeType: 'image/jpeg',
      ),
      SharedFileInfo(
        name: 'IMG_4023.jpg',
        size: 8000000,
        mimeType: 'image/jpeg',
      ),
    ],
    this.excludedFiles = const [],
  });

  factory fromFiles({
    required List<SharedFileInfo> activeFiles,
    List<SharedFileInfo> excludedFiles = const [],
  }) {
    if (activeFiles.isEmpty) {
      return ShareIntegrationItem(
        title: 'No files selected',
        subtitle: 'All files excluded',
        fileCount: 0,
        totalSize: '0 B',
        files: activeFiles,
        excludedFiles: excludedFiles,
      );
    }

    final totalBytes = activeFiles.fold<int>(0, (sum, f) => sum + f.size);
    final count = activeFiles.length;
    final totalSize = formatFileSize(bytes: totalBytes);
    final String title;
    final String subtitle;

    if (count == 1) {
      final first = activeFiles.first;
      title = first.name;
      final mime = first.mimeType;
      final sizeStr = formatFileSize(bytes: first.size);
      subtitle = mime.isNotEmpty ? '$sizeStr · $mime' : sizeStr;
    } else {
      final first = activeFiles.first;
      title = '${first.name} + ${count - 1} more';
      subtitle = '$count files · $totalSize';
    }

    return ShareIntegrationItem(
      title: title,
      subtitle: subtitle,
      fileCount: count,
      totalSize: totalSize,
      files: activeFiles,
      excludedFiles: excludedFiles,
    );
  }

  final String title;
  final String subtitle;
  final int fileCount;
  final String totalSize;
  final List<SharedFileInfo> files;
  final List<SharedFileInfo> excludedFiles;

  ShareIntegrationItem copyWith({
    String? title,
    String? subtitle,
    int? fileCount,
    String? totalSize,
    List<SharedFileInfo>? files,
    List<SharedFileInfo>? excludedFiles,
  }) {
    return ShareIntegrationItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      fileCount: fileCount ?? this.fileCount,
      totalSize: totalSize ?? this.totalSize,
      files: files ?? this.files,
      excludedFiles: excludedFiles ?? this.excludedFiles,
    );
  }
}

/// Mock data representation for destination connection.
class ShareIntegrationDestination {
  const new({
    this.name = 'Production',
    this.host = 'prod.relaydock.io',
    this.protocol = ConnectionProtocol.sftp,
    this.status = ConnectionStatus.online,
    this.destinationPath = '/var/www/releases/assets',
  });

  final String name;
  final String host;
  final ConnectionProtocol protocol;
  final ConnectionStatus status;
  final String destinationPath;

  ShareIntegrationDestination copyWith({
    String? name,
    String? host,
    ConnectionProtocol? protocol,
    ConnectionStatus? status,
    String? destinationPath,
  }) {
    return ShareIntegrationDestination(
      name: name ?? this.name,
      host: host ?? this.host,
      protocol: protocol ?? this.protocol,
      status: status ?? this.status,
      destinationPath: destinationPath ?? this.destinationPath,
    );
  }
}

/// Mock data container for share integration sheet.
class ShareIntegrationData {
  const new({
    this.item = const ShareIntegrationItem(),
    this.destination = const ShareIntegrationDestination(),
    this.preserveOriginalFilenames = true,
    this.simultaneousTransfers = 3,
  });

  final ShareIntegrationItem item;
  final ShareIntegrationDestination destination;
  final bool preserveOriginalFilenames;
  final int simultaneousTransfers;

  ShareIntegrationData copyWith({
    ShareIntegrationItem? item,
    ShareIntegrationDestination? destination,
    bool? preserveOriginalFilenames,
    int? simultaneousTransfers,
  }) {
    return ShareIntegrationData(
      item: item ?? this.item,
      destination: destination ?? this.destination,
      preserveOriginalFilenames:
          preserveOriginalFilenames ?? this.preserveOriginalFilenames,
      simultaneousTransfers:
          simultaneousTransfers ?? this.simultaneousTransfers,
    );
  }
}
