import 'package:flutter/widgets.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_identity_card.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class ConnectionIdentitySection extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context) {
    return ConnectionIdentityCard(connection: connection);
  }
}
