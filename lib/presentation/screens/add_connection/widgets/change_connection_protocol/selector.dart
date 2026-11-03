import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/change_connection_protocol/sheet.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ChangeConnectionProtocolSelector extends StatelessWidget {
  const new({required this.value, required this.onChange, super.key});

  final ConnectionProtocol value;
  final ValueChanged<ConnectionProtocol> onChange;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Future<void> handleOnPress() async {
      await showChangeConnectionProtocolSheet(
        context,
        selectedConnectionProtocol: value,
        onChange: onChange,
      );
    }

    return FTile(
      prefix: ConnectionProtocolGlyph(connectionProtocol: value),
      title: Text(
        value.name,
        style: theme.typography.display.xs.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w600,
        ),
      ),
      subtitle: Text(value.hint),
      suffix: IntrinsicWidth(
        child: FButton(
          variant: .ghost,
          size: .xs,
          onPress: handleOnPress,
          child: const Text('Change'),
        ),
      ),
    );
  }
}
