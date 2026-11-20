import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/add_connection_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/retained_files_banner.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_sheet.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_summary_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/share_header.dart';
import 'package:sharehop/presentation/overlays/share/widgets/simultaneous_transfers/simultaneous_transfers_card.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

Future<void> showShareIntegrationSheet(
  BuildContext context, {
  ShareIntegrationData data = const ShareIntegrationData(),
  Future<Map<String, dynamic>?>? sharedDataFuture,
  List<ConnectionViewModel>? availableConnections,
  UuidValue? selectedConnectionId,
  ValueChanged<ConnectionViewModel>? onConnectionChanged,
  bool isUploading = false,
  VoidCallback? onUpload,
  VoidCallback? onBrowse,
  VoidCallback? onOpenAddConnection,
  VoidCallback? onSelectDestination,
  VoidCallback? onClose,
  ValueChanged<bool>? onPreserveFilenamesChanged,
  VoidCallback? onOpenFiles,
  ValueChanged<SharedFileInfo>? onExcludeFile,
  ValueChanged<SharedFileInfo>? onIncludeFile,
  ValueChanged<int>? onSimultaneousTransfersChanged,
  WidgetBuilder? builder,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder:
        builder ??
        (sheetContext) => ShareIntegrationSheet(
          data: data,
          sharedDataFuture: sharedDataFuture,
          availableConnections: availableConnections,
          selectedConnectionId: selectedConnectionId,
          onConnectionChanged: onConnectionChanged,
          isUploading: isUploading,
          onUpload: onUpload,
          onBrowse: onBrowse,
          onOpenAddConnection: onOpenAddConnection,
          onSelectDestination: onSelectDestination,
          onClose: onClose,
          onPreserveFilenamesChanged: onPreserveFilenamesChanged,
          onOpenFiles: onOpenFiles,
          onExcludeFile: onExcludeFile,
          onIncludeFile: onIncludeFile,
          onSimultaneousTransfersChanged: onSimultaneousTransfersChanged,
        ),
  );
}

Future<void> showIntegrationSheet(
  BuildContext context, {
  ShareIntegrationData data = const ShareIntegrationData(),
  Future<Map<String, dynamic>?>? sharedDataFuture,
  List<ConnectionViewModel>? availableConnections,
  UuidValue? selectedConnectionId,
  ValueChanged<ConnectionViewModel>? onConnectionChanged,
  bool isUploading = false,
  VoidCallback? onUpload,
  VoidCallback? onBrowse,
  VoidCallback? onOpenAddConnection,
  VoidCallback? onSelectDestination,
  VoidCallback? onClose,
  ValueChanged<bool>? onPreserveFilenamesChanged,
  VoidCallback? onOpenFiles,
  ValueChanged<SharedFileInfo>? onExcludeFile,
  ValueChanged<SharedFileInfo>? onIncludeFile,
  ValueChanged<int>? onSimultaneousTransfersChanged,
  WidgetBuilder? builder,
}) => showShareIntegrationSheet(
  context,
  data: data,
  sharedDataFuture: sharedDataFuture,
  availableConnections: availableConnections,
  selectedConnectionId: selectedConnectionId,
  onConnectionChanged: onConnectionChanged,
  isUploading: isUploading,
  onUpload: onUpload,
  onBrowse: onBrowse,
  onOpenAddConnection: onOpenAddConnection,
  onSelectDestination: onSelectDestination,
  onClose: onClose,
  onPreserveFilenamesChanged: onPreserveFilenamesChanged,
  onOpenFiles: onOpenFiles,
  onExcludeFile: onExcludeFile,
  onIncludeFile: onIncludeFile,
  onSimultaneousTransfersChanged: onSimultaneousTransfersChanged,
  builder: builder,
);

class ShareIntegrationSheet extends HookWidget {
  const new({
    this.data = const ShareIntegrationData(),
    this.sharedDataFuture,
    this.availableConnections,
    this.selectedConnectionId,
    this.onConnectionChanged,
    this.isUploading = false,
    this.onUpload,
    this.onBrowse,
    this.onOpenAddConnection,
    this.onSelectDestination,
    this.onClose,
    this.onPreserveFilenamesChanged,
    this.onOpenFiles,
    this.onExcludeFile,
    this.onIncludeFile,
    this.onSimultaneousTransfersChanged,
    super.key,
  });

  final ShareIntegrationData data;
  final Future<Map<String, dynamic>?>? sharedDataFuture;
  final List<ConnectionViewModel>? availableConnections;
  final UuidValue? selectedConnectionId;
  final ValueChanged<ConnectionViewModel>? onConnectionChanged;
  final bool isUploading;
  final VoidCallback? onUpload;
  final VoidCallback? onBrowse;
  final VoidCallback? onOpenAddConnection;
  final VoidCallback? onSelectDestination;
  final VoidCallback? onClose;
  final ValueChanged<bool>? onPreserveFilenamesChanged;
  final VoidCallback? onOpenFiles;
  final ValueChanged<SharedFileInfo>? onExcludeFile;
  final ValueChanged<SharedFileInfo>? onIncludeFile;
  final ValueChanged<int>? onSimultaneousTransfersChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final currentDestination = useState<ShareIntegrationDestination>(
      data.destination,
    );
    final currentSimultaneousTransfers = useState<int>(
      data.simultaneousTransfers,
    );
    final currentItem = useState<ShareIntegrationItem>(data.item);
    final rawSharedData = useFuture(sharedDataFuture);

    useEffect(() {
      if (rawSharedData.hasData && rawSharedData.data != null) {
        final raw = rawSharedData.data!;
        final uris =
            (raw['uris'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            const <String>[];
        final files = ((raw['files'] as List<dynamic>?) ?? [])
            .whereType<Map<dynamic, dynamic>>()
            .toList();
        final sharedText = raw['text'] as String?;

        final List<SharedFileInfo> parsedFiles;
        if (files.isNotEmpty) {
          parsedFiles = files.map((f) {
            return SharedFileInfo(
              name: f['name']?.toString() ?? 'File',
              size: (f['size'] as num?)?.toInt() ?? 0,
              mimeType: f['mimeType']?.toString() ?? '',
              uri: f['uri']?.toString() ?? '',
            );
          }).toList();
        } else if (uris.isNotEmpty) {
          parsedFiles = uris.map((u) {
            final uriObj = Uri.tryParse(u);
            final name = uriObj?.pathSegments.lastOrNull ?? 'File';
            return SharedFileInfo(name: name, uri: u);
          }).toList();
        } else if (sharedText != null && sharedText.isNotEmpty) {
          parsedFiles = [
            SharedFileInfo(
              name: 'Shared text',
              size: sharedText.length,
              mimeType: 'text/plain',
            ),
          ];
        } else {
          parsedFiles = const [
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
          ];
        }

        if (parsedFiles.isNotEmpty && (files.isNotEmpty || uris.isNotEmpty)) {
          currentItem.value = ShareIntegrationItem.fromFiles(
            activeFiles: parsedFiles,
          );
        } else if (sharedText != null && sharedText.isNotEmpty) {
          currentItem.value = ShareIntegrationItem(
            title: 'Shared text',
            subtitle: sharedText.length > 30
                ? '${sharedText.substring(0, 30)}...'
                : sharedText,
            fileCount: parsedFiles.length,
            totalSize: formatFileSize(bytes: sharedText.length),
            files: parsedFiles,
          );
        }
      }
      return null;
    }, [rawSharedData.data]);

    useEffect(() {
      currentDestination.value = data.destination;
      return null;
    }, [data.destination]);

    useEffect(() {
      currentSimultaneousTransfers.value = data.simultaneousTransfers;
      return null;
    }, [data.simultaneousTransfers]);

    useEffect(() {
      currentItem.value = data.item;
      return null;
    }, [data.item]);

    final hasNoConnections = availableConnections != null
        ? availableConnections!.isEmpty
        : currentDestination.value.name.isEmpty;

    void handleOnChangeSimultaneousTransfers(int limit) {
      currentSimultaneousTransfers.value = limit;
      onSimultaneousTransfersChanged?.call(limit);
    }

    void handleOnPressUpload() {
      onUpload?.call();
    }

    void handleOnExcludeFile(SharedFileInfo file) {
      final active = currentItem.value.files.where((f) => f != file).toList();
      final excluded = [...currentItem.value.excludedFiles, file];
      currentItem.value = ShareIntegrationItem.fromFiles(
        activeFiles: active,
        excludedFiles: excluded,
      );
      onExcludeFile?.call(file);
    }

    void handleOnIncludeFile(SharedFileInfo file) {
      final excluded = currentItem.value.excludedFiles
          .where((f) => f != file)
          .toList();
      final active = [...currentItem.value.files, file];
      currentItem.value = ShareIntegrationItem.fromFiles(
        activeFiles: active,
        excludedFiles: excluded,
      );
      onIncludeFile?.call(file);
    }

    void handleOnPressFiles() {
      if (onOpenFiles != null) {
        onOpenFiles!.call();
        return;
      }

      unawaited(
        showSelectedFilesSheet(
          context,
          files: currentItem.value.files,
          excludedFiles: currentItem.value.excludedFiles,
          onExcludeFile: handleOnExcludeFile,
          onIncludeFile: handleOnIncludeFile,
        ),
      );
    }

    void handleOnChangeConnection(ConnectionViewModel conn) {
      currentDestination.value = ShareIntegrationDestination(
        name: conn.displayName,
        host: conn.remoteAddress,
        protocol: conn.protocol,
        status: conn.status,
        destinationPath: conn.rootPath,
      );
      onConnectionChanged?.call(conn);
    }

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: Spacing.lg,
            children: [
              ShareHeader(
                fileCount: currentItem.value.fileCount,
                totalSize: currentItem.value.totalSize,
              ),
              SelectedFilesSummaryCard(
                item: currentItem.value,
                onOpenFiles: handleOnPressFiles,
              ),
              Column(
                spacing: Spacing.md,
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Text(
                    'Destination',
                    style: theme.typography.body.xs.copyWith(
                      color: theme.colors.mutedForeground,
                      fontWeight: .w600,
                    ),
                  ),

                  DestinationConnectionCard(
                    destination: currentDestination.value,
                    availableConnections: availableConnections,
                    selectedConnectionId: selectedConnectionId,
                    onConnectionChanged: handleOnChangeConnection,
                    onPress: onSelectDestination,
                    onOpenAddConnection: onOpenAddConnection,
                  ),
                  DestinationPathCard(
                    path: currentDestination.value.destinationPath,
                    onBrowse: onBrowse,
                  ),
                  SimultaneousTransfersCard(
                    simultaneousTransfers: currentSimultaneousTransfers.value,
                    onSimultaneousTransfersChanged:
                        handleOnChangeSimultaneousTransfers,
                  ),
                  if (hasNoConnections) ...[
                    AddConnectionCard(onPressOpen: onOpenAddConnection),
                    RetainedFilesBanner(fileCount: currentItem.value.fileCount),
                  ],
                  const SizedBox(height: Spacing.xs2),
                  SizedBox(
                    width: double.infinity,
                    child: FButton(
                      size: .lg,
                      onPress:
                          isUploading || currentItem.value.fileCount == 0
                              ? null
                              : handleOnPressUpload,
                      prefix: const Icon(FLucideIcons.cloudUpload, size: 20),
                      child: Text(
                        isUploading
                            ? 'Uploading...'
                            : currentItem.value.fileCount == 0
                            ? 'No files selected'
                            : 'Upload ${currentItem.value.fileCount} files',
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Transfer continues securely in the background.',
                      style: theme.typography.body.xs2.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                      textAlign: .center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
