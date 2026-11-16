import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/widgets/primitives/empty_state.dart';

class ManageOtherConnectionsEmptyState extends StatelessWidget {
  const new({
    this.title = 'No other connections available',
    this.description =
        'Add a new connection or switch filter to see other connections.',
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return EmptyState.card(
      icon: FLucideIcons.network,
      title: title,
      description: description,
    );
  }
}
