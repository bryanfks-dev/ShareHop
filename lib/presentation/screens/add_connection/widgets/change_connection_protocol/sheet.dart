import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

Future<void> showSelectionConnectionProtocolSheet(
  BuildContext context, {
  required ValueChanged<ConnectionProtocol> onChange,
  ConnectionProtocol? selectedConnectionProtocol,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) => _ChangeConnectionProtocolSheetContent(
      selectedConnectionProtocol: selectedConnectionProtocol,
      onChange: onChange,
    ),
  );
}

Future<void> showChangeConnectionProtocolSheet(
  BuildContext context, {
  required ValueChanged<ConnectionProtocol> onChange,
  ConnectionProtocol? selectedConnectionProtocol,
}) => showSelectionConnectionProtocolSheet(
  context,
  onChange: onChange,
  selectedConnectionProtocol: selectedConnectionProtocol,
);

class _ChangeConnectionProtocolSheetContent extends HookWidget {
  const new({required this.selectedConnectionProtocol, required this.onChange});

  final ConnectionProtocol? selectedConnectionProtocol;
  final ValueChanged<ConnectionProtocol> onChange;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final innerSelectedConnectionProtocol = useState<ConnectionProtocol?>(
      selectedConnectionProtocol,
    );

    void handleOnPress({required ConnectionProtocol connectionProtocol}) {
      innerSelectedConnectionProtocol.value = connectionProtocol;
      onChange(connectionProtocol);
      context.navigator.pop();
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
              Text(
                'Select Connection Protocol',
                style: theme.typography.display.sm.copyWith(fontWeight: .w600),
              ),
              Column(
                mainAxisSize: .min,
                spacing: Spacing.md,
                children: [
                  for (final protocol in ConnectionProtocol.values)
                    _ChangeConnectionProtocolSheetItem(
                      connectionProtocol: protocol,
                      value: innerSelectedConnectionProtocol.value == protocol,
                      onPress: () =>
                          handleOnPress(connectionProtocol: protocol),
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

class _ChangeConnectionProtocolSheetItem extends StatelessWidget {
  const new({
    required this.connectionProtocol,
    required this.onPress,
    this.value = false,
  });

  final ConnectionProtocol connectionProtocol;
  final bool value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnChange({required bool value}) {
      onPress();
    }

    return Container(
      padding: .all(theme.style.pagePadding.top),
      decoration: BoxDecoration(
        border: .all(color: value ? theme.colors.primary : theme.colors.border),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: FRadio(
        label: Text(connectionProtocol.displayName),
        description: Text(connectionProtocol.hint),
        value: value,
        onChange: (val) => handleOnChange(value: val),
      ),
    );
  }
}
