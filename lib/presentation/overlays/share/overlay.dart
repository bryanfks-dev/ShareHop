import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/file_transfer_status.dart';
import 'package:sharehop/core/models/file_transfer_history_model.dart';
import 'package:sharehop/di/file_transfer_history_di.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/share_integration_sheet.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid.dart';

class ShareOverlay extends HookConsumerWidget {
  const new({this.channel = const MethodChannel('share_channel'), super.key});

  final MethodChannel channel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleOnClose() async {
      try {
        await channel.invokeMethod<void>('close');
      } on Object catch (e) {
        log('Failed to close native activity', error: e);
      }
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop();
      }
    }

    final appConfig = ref.watch(settingsControllerProvider);
    final isUploading = useState<bool>(false);
    final preserveFilenames = useState<bool>(true);
    final simultaneousTransfers = useState<int>(
      appConfig.value?.simultaneousTransfersLimit ?? 3,
    );
    final activeFiles = useState<List<SharedFileInfo>>(const [
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
    ]);
    final currentConnection = useState<ConnectionViewModel?>(null);

    final pinnedState = ref.watch(managePinnedConnectionsControllerProvider);
    final allConnections = [
      ...pinnedState.pinnedConnections,
      ...pinnedState.otherConnections,
    ];

    final initialConnection =
        pinnedState.pinnedConnections.firstOrNull ??
        pinnedState.otherConnections.firstOrNull;

    useEffect(() {
      currentConnection.value = initialConnection;
      return null;
    }, [initialConnection]);

    Future<void> handleOnPressOpenAddConnection() async {
      try {
        await channel.invokeMethod<void>('openApp');
      } on Object catch (e) {
        log('Failed to open app', error: e);
      }
      await handleOnClose();
    }

    Future<void> handleOnPressUpload() async {
      if (isUploading.value || activeFiles.value.isEmpty) {
        return;
      }
      isUploading.value = true;
      try {
        final targetConn = currentConnection.value;
        if (targetConn != null && activeFiles.value.isNotEmpty) {
          final repository = ref.read(fileTransferHistoryRepositoryProvider);
          final now = DateTime.now().toUtc();
          for (final f in activeFiles.value) {
            final model = FileTransferHistoryModel(
              id: const Uuid().v7obj(),
              fileName: f.name,
              fileSize: f.size,
              fileMimeType: f.mimeType.isNotEmpty
                  ? f.mimeType
                  : 'application/octet-stream',
              sourceName: 'External Share',
              destinationName: targetConn.displayName,
              status: FileTransferStatus.inProgress,
              createdAt: now,
              updatedAt: now,
            );
            await repository.insert(model);
          }
        }
      } on Object catch (e, st) {
        log('Failed to save file transfer records', error: e, stackTrace: st);
      } finally {
        isUploading.value = false;
        await handleOnClose();
      }
    }

    final sharedDataFuture = useMemoized(
      () => channel.invokeMapMethod<String, dynamic>('getSharedData'),
      [channel],
    );

    final isSheetOpened = useRef(false);

    useEffect(() {
      var isMounted = true;

      scheduleMicrotask(() async {
        if (!isMounted || !context.mounted || isSheetOpened.value) {
          return;
        }
        isSheetOpened.value = true;

        final targetConn = currentConnection.value ?? initialConnection;
        final destination = targetConn != null
            ? ShareIntegrationDestination(
                name: targetConn.displayName,
                host: targetConn.remoteAddress,
                protocol: targetConn.protocol,
                status: targetConn.status,
                destinationPath: targetConn.rootPath,
              )
            : const ShareIntegrationDestination();

        final data = ShareIntegrationData(
          destination: destination,
          preserveOriginalFilenames: preserveFilenames.value,
          simultaneousTransfers: simultaneousTransfers.value,
        );

        await showIntegrationSheet(
          context,
          sharedDataFuture: sharedDataFuture,
          data: data,
          availableConnections: allConnections,
          selectedConnectionId: targetConn?.id,
          onConnectionChanged: (conn) {
            currentConnection.value = conn;
          },
          isUploading: isUploading.value,
          onUpload: handleOnPressUpload,
          onOpenAddConnection: handleOnPressOpenAddConnection,
          onClose: () {
            if (context.mounted && context.navigator.canPop()) {
              context.navigator.pop();
            }
          },
          onPreserveFilenamesChanged: (val) {
            preserveFilenames.value = val;
          },
          onExcludeFile: (file) {
            activeFiles.value = activeFiles.value
                .where((f) => f != file)
                .toList();
          },
          onIncludeFile: (file) {
            if (!activeFiles.value.contains(file)) {
              activeFiles.value = [...activeFiles.value, file];
            }
          },
          onSimultaneousTransfersChanged: (val) {
            simultaneousTransfers.value = val;
          },
        );

        if (isMounted) {
          await handleOnClose();
        }
      });

      return () {
        isMounted = false;
      };
    }, const []);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          unawaited(handleOnClose());
        }
      },
      child: const FScaffold(
        scaffoldStyle: .delta(backgroundColor: Colors.transparent),
        child: SizedBox.expand(),
      ),
    );
  }
}
