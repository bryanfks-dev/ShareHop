import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class DestinationConnectionEmptyState extends StatelessWidget {
  const new({this.onAddConnection, super.key});

  final VoidCallback? onAddConnection;

  @override
  Widget build(BuildContext context) {
    void handleOnPressAddConnection() {
      onAddConnection?.call();
    }

    return EmptyState.card(
      icon: FLucideIcons.hardDriveDownload,
      title: 'No available connections',
      description:
          'Add a connection to configure a destination for file transfers.',
      action: onAddConnection != null
          ? FButton(
              onPress: handleOnPressAddConnection,
              child: const Text('Add connection'),
            )
          : null,
    );
  }
}
