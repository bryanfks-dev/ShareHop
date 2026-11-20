import 'package:flutter/widgets.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_filter_chip.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class DestinationConnectionProtocolFilterChips extends StatelessWidget {
  const new({
    required this.protocols,
    required this.selectedProtocol,
    required this.onSelectProtocol,
    super.key,
  });

  final List<ConnectionProtocol> protocols;
  final ConnectionProtocol? selectedProtocol;
  final ValueChanged<ConnectionProtocol?> onSelectProtocol;

  @override
  Widget build(BuildContext context) {
    void handleOnPressAll() {
      onSelectProtocol(null);
    }

    void handleOnPressProtocol(ConnectionProtocol protocol) {
      onSelectProtocol(protocol);
    }

    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: Spacing.xs,
        children: [
          ManageOtherConnectionsFilterChip(
            label: 'All',
            isSelected: selectedProtocol == null,
            onPress: handleOnPressAll,
          ),
          for (final protocol in protocols)
            ManageOtherConnectionsFilterChip(
              key: ValueKey(protocol),
              label: protocol.displayName,
              isSelected: selectedProtocol == protocol,
              onPress: () => handleOnPressProtocol(protocol),
            ),
        ],
      ),
    );
  }
}
