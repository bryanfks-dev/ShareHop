import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/extensions/enums/connection_status_extension.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

Future<void> showConnectionInformationSheet(
  BuildContext context, {
  required ConnectionViewModel connection,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) =>
        _ConnectionInformationSheetContent(connection: connection),
  );
}

class _ConnectionInformationSheetContent extends StatelessWidget {
  const new({required this.connection});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressClose() {
      context.navigator.pop();
    }

    Future<void> handleOnCopy(String label, String value) async {
      await Clipboard.setData(ClipboardData(text: value));
      if (context.mounted) {
        showFToast(context: context, title: Text('$label copied to clipboard'));
      }
    }

    Color statusColor;
    switch (connection.status) {
      case .online:
        statusColor = theme.colors.app.success;
      case .ready:
        statusColor = theme.colors.app.accentBlue;
      case .idle:
        statusColor = theme.colors.app.accentTeal;
      case .offline:
        statusColor = theme.colors.mutedForeground;
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
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'Connection Details',
                    style: theme.typography.display.sm.copyWith(
                      color: theme.colors.foreground,
                      fontWeight: .w600,
                    ),
                  ),
                  FButton.icon(
                    size: .sm,
                    variant: .ghost,
                    onPress: handleOnPressClose,
                    child: const Icon(FLucideIcons.x, size: 18),
                  ),
                ],
              ),
              Row(
                spacing: Spacing.md,
                children: [
                  ConnectionProtocolGlyph(
                    connectionProtocol: connection.protocol,
                    status: connection.status,
                    size: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      spacing: Spacing.xs2,
                      children: [
                        Text(
                          connection.displayName,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.typography.display.xs.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: .w700,
                          ),
                        ),
                        Text(
                          connection.protocol.displayName,
                          style: theme.typography.body.xs2.copyWith(
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FTileGroup(
                divider: .full,
                children: [
                  _ConnectionInformationDetailTile(
                    label: 'Status',
                    valueWidget: Row(
                      mainAxisSize: .min,
                      spacing: Spacing.xs,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: .circle,
                          ),
                        ),
                        Text(
                          connection.status.label,
                          style: theme.typography.body.xs.copyWith(
                            color: statusColor,
                            fontWeight: .w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ConnectionInformationDetailTile(
                    label: 'Remote Address',
                    value: connection.remoteAddress,
                    onCopy: () => handleOnCopy(
                      'Remote address',
                      connection.remoteAddress,
                    ),
                  ),
                  _ConnectionInformationDetailTile(
                    label: 'Protocol',
                    value: connection.protocol.shortName,
                  ),
                  _ConnectionInformationDetailTile(
                    label: 'Connection ID',
                    value: connection.id,
                    onCopy: () => handleOnCopy('Connection ID', connection.id),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  FButton(
                    size: .sm,
                    onPress: handleOnPressClose,
                    child: const Text('Close'),
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

class _ConnectionInformationDetailTile extends StatelessWidget with FTileMixin {
  const new({required this.label, this.value, this.valueWidget, this.onCopy});

  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTile(
      onPress: onCopy,
      style: .delta(
        contentDecoration: .delta([
          .all(.boxDelta(color: theme.colors.app.transparent)),
        ]),
      ),
      title: Text(
        label,
        style: theme.typography.body.xs.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      suffix: Row(
        mainAxisSize: .min,
        spacing: Spacing.xs,
        children: [
          if (valueWidget != null)
            valueWidget!
          else if (value != null)
            Flexible(
              child: Text(
                value!,
                maxLines: 1,
                overflow: .ellipsis,
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w500,
                ),
              ),
            ),
          if (onCopy != null)
            Icon(
              FLucideIcons.copy,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
        ],
      ),
    );
  }
}
