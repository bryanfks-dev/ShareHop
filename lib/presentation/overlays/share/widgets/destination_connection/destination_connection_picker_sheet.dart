import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_empty_state.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_picker_header.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_protocol_filter_chips.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_section_list.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:uuid/uuid_value.dart';

Future<ConnectionViewModel?> showDestinationConnectionPickerSheet(
  BuildContext context, {
  required List<ConnectionViewModel> connections,
  UuidValue? selectedId,
  String? selectedHost,
  String? selectedName,
  VoidCallback? onOpenAddConnection,
  VoidCallback? onClose,
}) async {
  final result = await showFSheet<ConnectionViewModel>(
    context: context,
    side: .btt,
    onClosing: onClose,
    builder: (sheetContext) => _DestinationConnectionPickerSheet(
      connections: connections,
      selectedId: selectedId,
      selectedHost: selectedHost,
      selectedName: selectedName,
      onOpenAddConnection: onOpenAddConnection,
      onClose: onClose,
    ),
  );
  onClose?.call();
  return result;
}

typedef ShowDestinationConnectionPickerSheet =
    Future<ConnectionViewModel?> Function(
      BuildContext context, {
      required List<ConnectionViewModel> connections,
      UuidValue? selectedId,
      String? selectedHost,
      String? selectedName,
      VoidCallback? onOpenAddConnection,
      VoidCallback? onClose,
    });

/// Alias for [showDestinationConnectionPickerSheet].
const ShowDestinationConnectionPickerSheet showConnectionPickerSheet =
    showDestinationConnectionPickerSheet;

typedef DestinationConnectionPickerSheet = _DestinationConnectionPickerSheet;

class _DestinationConnectionPickerSheet extends HookWidget {
  const new({
    required this.connections,
    this.selectedId,
    this.selectedHost,
    this.selectedName,
    this.onOpenAddConnection,
    this.onClose,
  });

  final List<ConnectionViewModel> connections;
  final UuidValue? selectedId;
  final String? selectedHost;
  final String? selectedName;
  final VoidCallback? onOpenAddConnection;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final selectedProtocol = useState<ConnectionProtocol?>(null);

    final protocolsInConnections = useMemoized(
      () => connections.map((c) => c.protocol).toSet().toList(),
      [connections],
    );

    final filteredConnections = useMemoized(() {
      if (selectedProtocol.value == null) {
        return connections;
      }
      return connections
          .where((c) => c.protocol == selectedProtocol.value)
          .toList();
    }, [connections, selectedProtocol.value]);

    final pinnedConnections = useMemoized(
      () => filteredConnections.where((c) => c.isPinned).toList(),
      [filteredConnections],
    );
    final otherConnections = useMemoized(
      () => filteredConnections.where((c) => !c.isPinned).toList(),
      [filteredConnections],
    );
    final hasSections =
        pinnedConnections.isNotEmpty && otherConnections.isNotEmpty;

    void handleOnPressClose() {
      onClose?.call();
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop();
      }
    }

    void handleOnPressAddConnection() {
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop();
      }
      onOpenAddConnection?.call();
    }

    void handleOnPressSelect(ConnectionViewModel conn) {
      if (context.mounted && context.navigator.canPop()) {
        context.navigator.pop(conn);
      }
    }

    void handleOnSelectProtocol(ConnectionProtocol? protocol) {
      selectedProtocol.value = protocol;
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
            spacing: Spacing.md,
            children: [
              DestinationConnectionPickerHeader(onClose: handleOnPressClose),
              if (protocolsInConnections.length > 1)
                DestinationConnectionProtocolFilterChips(
                  protocols: protocolsInConnections,
                  selectedProtocol: selectedProtocol.value,
                  onSelectProtocol: handleOnSelectProtocol,
                ),
              if (connections.isEmpty)
                DestinationConnectionEmptyState(
                  onAddConnection: onOpenAddConnection != null
                      ? handleOnPressAddConnection
                      : null,
                )
              else
                DestinationConnectionSectionList(
                  pinnedConnections: pinnedConnections,
                  otherConnections: otherConnections,
                  filteredConnections: filteredConnections,
                  hasSections: hasSections,
                  selectedId: selectedId,
                  selectedHost: selectedHost,
                  selectedName: selectedName,
                  onSelect: handleOnPressSelect,
                  onAddConnection: onOpenAddConnection != null
                      ? handleOnPressAddConnection
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
