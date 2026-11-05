import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/controllers/smb_storage_status_controller.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/storage_usage_card.dart';

class StorageUsageSection extends ConsumerWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (connection.protocol != ConnectionProtocol.smb) {
      return const StorageUsageCard();
    }

    final storageAsync =
        ref.watch(smbStorageStatusControllerProvider(connection));

    void handleOnRefresh() {
      unawaited(
        ref
            .read(smbStorageStatusControllerProvider(connection).notifier)
            .refresh(),
      );
    }

    return storageAsync.when(
      data: (status) => StorageUsageCard(
        storageStatus: status,
        onRefresh: handleOnRefresh,
      ),
      loading: () => const StorageUsageCard(isLoading: true),
      error: (_, _) => StorageUsageCard(onRefresh: handleOnRefresh),
    );
  }
}
