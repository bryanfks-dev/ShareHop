import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_add_button.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_tile.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

class DestinationConnectionSectionList extends StatelessWidget {
  const new({
    required this.pinnedConnections,
    required this.otherConnections,
    required this.filteredConnections,
    required this.hasSections,
    required this.onSelect,
    this.selectedId,
    this.selectedHost,
    this.selectedName,
    this.onAddConnection,
    super.key,
  });

  final List<ConnectionViewModel> pinnedConnections;
  final List<ConnectionViewModel> otherConnections;
  final List<ConnectionViewModel> filteredConnections;
  final bool hasSections;
  final UuidValue? selectedId;
  final String? selectedHost;
  final String? selectedName;
  final ValueChanged<ConnectionViewModel> onSelect;
  final VoidCallback? onAddConnection;

  bool _isConnectionSelected({required ConnectionViewModel connection}) {
    return connection.id == selectedId ||
        (selectedId == null &&
            connection.remoteAddress == selectedHost &&
            connection.displayName == selectedName);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (hasSections) {
      return Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: Spacing.sm,
        children: [
          Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.xs2,
            children: [
              Text(
                'Pinned Connections',
                style: theme.typography.display.xs2.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: .w700,
                ),
              ),
              for (final conn in pinnedConnections)
                DestinationConnectionTile(
                  connection: conn,
                  isSelected: _isConnectionSelected(connection: conn),
                  onSelect: onSelect,
                ),
            ],
          ),
          Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.xs2,
            children: [
              Text(
                'Other Connections',
                style: theme.typography.display.xs2.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: .w700,
                ),
              ),
              for (final conn in otherConnections)
                DestinationConnectionTile(
                  connection: conn,
                  isSelected: _isConnectionSelected(connection: conn),
                  onSelect: onSelect,
                ),
            ],
          ),
          if (onAddConnection != null)
            DestinationConnectionAddButton(onAddConnection: onAddConnection),
        ],
      );
    }

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: Spacing.xs2,
      children: [
        for (final conn in filteredConnections)
          DestinationConnectionTile(
            connection: conn,
            isSelected: _isConnectionSelected(connection: conn),
            onSelect: onSelect,
          ),
        if (onAddConnection != null)
          DestinationConnectionAddButton(onAddConnection: onAddConnection),
      ],
    );
  }
}
