import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class ConnectionListEmptyState extends StatelessWidget {
  const new({
    this.title = 'No pinned connections',
    this.description =
        'Tap Manage to pin your favorite connections for quick access here.',
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return EmptyState.card(
      icon: FLucideIcons.pinOff,
      title: title,
      description: description,
    );
  }
}
