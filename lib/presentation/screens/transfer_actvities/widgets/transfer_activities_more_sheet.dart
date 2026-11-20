import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/sheet.dart';
import 'package:forui/widgets/tile.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showTransferActivitiesMoreSheet(
  BuildContext context, {
  required Future<void> Function() onPressClearAll,
  required Future<void> Function() onPressRefresh,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _TransferActivitiesMoreSheet(
      onPressClearAll: onPressClearAll,
      onPressRefresh: onPressRefresh,
    ),
  );
}

class _TransferActivitiesMoreSheet extends StatelessWidget {
  const new({required this.onPressClearAll, required this.onPressRefresh});

  final Future<void> Function() onPressClearAll;
  final Future<void> Function() onPressRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressRefresh() {
      context.navigator.pop();
      unawaited(onPressRefresh());
    }

    void handleOnPressClearAll() {
      context.navigator.pop();
      unawaited(onPressClearAll());
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
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.md,
          children: [
            Text(
              'Transfer Options',
              style: theme.typography.display.sm.copyWith(
                color: theme.colors.foreground,
                fontWeight: .w600,
              ),
            ),
            FTileGroup(
              children: [
                FTile(
                  prefix: const Icon(FLucideIcons.refreshCw),
                  title: Text(
                    'Refresh transfers',
                    style: theme.typography.body.sm.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  onPress: handleOnPressRefresh,
                ),
                FTile(
                  prefix: Icon(
                    FLucideIcons.trash2,
                    color: theme.colors.destructive,
                  ),
                  title: Text(
                    'Clear all history',
                    style: theme.typography.body.sm.copyWith(
                      color: theme.colors.destructive,
                    ),
                  ),
                  onPress: handleOnPressClearAll,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
