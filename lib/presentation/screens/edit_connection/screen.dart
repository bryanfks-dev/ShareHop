import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/edit_connection/widgets/edit_connection_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/form.dart';

class EditConnectionScreen extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: EditConnectionHeader(connection: connection),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: Column(
            spacing: Spacing.xl,
            mainAxisSize: .min,
            children: [
              WebDavForm(connection: connection),
            ],
          ),
        ),
      ),
    );
  }
}
