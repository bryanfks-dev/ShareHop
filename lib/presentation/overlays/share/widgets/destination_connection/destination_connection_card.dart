import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_picker_sheet.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';
import 'package:uuid/uuid_value.dart';

class DestinationConnectionCard extends HookWidget {
  const new({
    required this.destination,
    this.availableConnections,
    this.selectedConnectionId,
    this.onConnectionChanged,
    this.onTap,
    this.onPress,
    this.onOpenAddConnection,
    super.key,
  });

  final ShareIntegrationDestination destination;
  final List<ConnectionViewModel>? availableConnections;
  final UuidValue? selectedConnectionId;
  final ValueChanged<ConnectionViewModel>? onConnectionChanged;
  final VoidCallback? onTap;
  final VoidCallback? onPress;
  final VoidCallback? onOpenAddConnection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final currentDestination = useState<ShareIntegrationDestination>(
      destination,
    );
    final currentSelectedId = useState<UuidValue?>(selectedConnectionId);

    useEffect(() {
      currentDestination.value = destination;
      return null;
    }, [destination]);

    useEffect(() {
      currentSelectedId.value = selectedConnectionId;
      return null;
    }, [selectedConnectionId]);

    Future<void> handleOnPress() async {
      (onPress ?? onTap)?.call();

      if (availableConnections == null) {
        return;
      }

      final selected = await showDestinationConnectionPickerSheet(
        context,
        connections: availableConnections ?? const [],
        selectedId: currentSelectedId.value,
        selectedHost: currentDestination.value.host,
        selectedName: currentDestination.value.name,
        onOpenAddConnection: onOpenAddConnection,
      );

      if (context.mounted && selected != null) {
        currentSelectedId.value = selected.id;
        currentDestination.value = ShareIntegrationDestination(
          name: selected.displayName,
          host: selected.remoteAddress,
          protocol: selected.protocol,
          status: selected.status,
          destinationPath: selected.rootPath,
        );
        onConnectionChanged?.call(selected);
      }
    }

    final activeDestination = currentDestination.value;

    return GestureDetector(
      onTap: handleOnPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const .symmetric(horizontal: Spacing.md, vertical: Spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.primary.withValues(alpha: 0.04),
          borderRadius: theme.style.borderRadius.lg,
          border: .all(
            color: theme.colors.primary,
            width: theme.style.borderWidth,
          ),
        ),
        child: Row(
          spacing: Spacing.md,
          children: [
            ConnectionProtocolGlyph(
              connectionProtocol: activeDestination.protocol,
              status: activeDestination.status,
              size: 44,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: Spacing.xs3,
                children: [
                  Text(
                    activeDestination.name,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: theme.typography.body.xs.copyWith(
                      color: theme.colors.foreground,
                      fontWeight: .w600,
                    ),
                  ),
                  Text(
                    activeDestination.host,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: theme.typography.body.xs2.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              FLucideIcons.chevronDown,
              size: 20,
              color: theme.colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
