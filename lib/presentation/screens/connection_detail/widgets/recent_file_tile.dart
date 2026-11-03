import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/utils/file_icon_resolver.dart';

class RecentFileTile extends StatelessWidget with FTileMixin {
  const new({required this.name, this.subtitle, this.onPress, super.key});

  final String name;
  final String? subtitle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final icon = resolveFileIcon(fileNameOrExtension: name);

    return FTile(
      onPress: onPress,
      prefix: Container(
        width: theme.style.sizes.field.md,
        height: theme.style.sizes.field.md,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.style.borderRadius.lg,
        ),
        child: Icon(
          icon,
          color: theme.colors.mutedForeground,
          size: theme.style.iconStyle.size,
        ),
      ),
      title: Text(
        name,
        overflow: .ellipsis,
        style: theme.typography.body.xs.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              overflow: .ellipsis,
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
              ),
            )
          : null,
      suffix: Icon(
        FLucideIcons.chevronRight,
        color: theme.colors.mutedForeground,
      ),
    );
  }
}
