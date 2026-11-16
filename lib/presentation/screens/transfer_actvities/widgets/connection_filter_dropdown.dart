import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class ConnectionFilterDropdown extends StatelessWidget {
  const new({
    required this.connections,
    required this.selectedConnection,
    required this.onChangeConnection,
    super.key,
  });

  final List<String> connections;
  final String? selectedConnection;
  final ValueChanged<String?> onChangeConnection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final items = <String, String>{
      'All Connections': '',
      for (final connection in connections) connection: connection,
    };

    void handleOnChange(String? value) {
      if (value == null || value.isEmpty) {
        onChangeConnection(null);
      } else {
        onChangeConnection(value);
      }
    }

    return FSelect<String>(
      label: Text(
        'Filter by Connection',
        style: theme.typography.body.xs.copyWith(
          color: theme.colors.foreground,
        ),
      ),
      hint: 'Select a connection',
      items: items,
      control: .lifted(
        value: selectedConnection ?? '',
        onChange: handleOnChange,
      ),
    );
  }
}
