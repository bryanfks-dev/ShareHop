import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/storage_usage_card.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class StorageUsageSection extends ConsumerWidget {
  const new({required this.connection, super.key});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const StorageUsageCard();
  }
}
