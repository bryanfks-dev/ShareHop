import 'package:flutter/material.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/open_split_workspace_tile.dart';

class LandscapeWorkspacePathSection extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context) {
    return OpenSplitWorkspaceTile(connection: connection);
  }
}
