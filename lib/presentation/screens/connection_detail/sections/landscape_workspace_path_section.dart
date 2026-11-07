import 'package:flutter/material.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/open_split_workspace_tile.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

class LandscapeWorkspacePathSection extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context) {
    return OpenSplitWorkspaceTile(connection: connection);
  }
}
