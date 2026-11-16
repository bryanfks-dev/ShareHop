import 'package:flutter/material.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/screens/manage_pinned_connections/widgets/manage_other_connections_filter_chip.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class ManageOtherConnectionsFilterChips extends StatelessWidget {
  const new({
    required this.selectedProtocol,
    required this.onPressProtocol,
    super.key,
  });

  final ConnectionProtocol? selectedProtocol;
  final void Function({required ConnectionProtocol? protocol}) onPressProtocol;

  @override
  Widget build(BuildContext context) {
    void handleOnPressAll() {
      onPressProtocol(protocol: null);
    }

    void handleOnPressProtocol(ConnectionProtocol protocol) {
      onPressProtocol(protocol: protocol);
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
          for (final protocol in ConnectionProtocol.values)
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
