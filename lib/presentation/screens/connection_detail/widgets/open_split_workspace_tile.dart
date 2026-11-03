import 'package:flutter/material.dart';
import 'package:forui/assets.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/tile.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class OpenSplitWorkspaceTile extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPress() {}

    return FTile(
      style: .delta(
        contentDecoration: .delta([
          .all(.boxDelta(color: theme.colors.app.black)),
        ]),
      ),
      onPress: handleOnPress,
      title: Text(
        'Open split workspace',
        style: theme.typography.body.xs.copyWith(
          color: theme.colors.app.white,
          fontWeight: .w700,
        ),
      ),
      subtitle: Text(
        'See device and remote file system in landscape',
        style: theme.typography.body.xs3.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
      suffix: const Icon(FLucideIcons.chevronRight),
      prefix: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: .circular(8),
        ),
        child: const Icon(FLucideIcons.columns),
      ),
    );
  }
}
