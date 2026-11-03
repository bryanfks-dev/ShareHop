import 'package:flutter/widgets.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_identity_card.dart';

class ConnectionIdentitySection extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context) {
    return ConnectionIdentityCard(connection: connection);
  }
}
