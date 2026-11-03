import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class SettingsSection extends StatelessWidget {
  const new({required this.title, required this.children, super.key});

  final String title;
  final List<SettingsSectionTileWithSuffix> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: Spacing.sm,
      children: [
        Text(
          title,
          style: theme.typography.display.xs2.copyWith(
            color: theme.colors.mutedForeground,
            fontWeight: .w700,
          ),
        ),
        FTileGroup(divider: .full, children: children),
      ],
    );
  }
}

sealed class SettingsSectionTileWithSuffix extends HookWidget with FTileMixin {
  const new({required this.title, super.key});

  final String title;
}

class SettingsSectionTileWithSwitchSuffix
    extends SettingsSectionTileWithSuffix {
  const new({
    required super.title,
    required this.value,
    required this.onChange,
    this.subtitle,
    super.key,
  });

  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChange;

  void handleOnPress() {
    onChange(!value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final subtitleWidget = subtitle == null
        ? null
        : Text(
            subtitle!,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.mutedForeground,
            ),
          );

    return Stack(
      children: [
        FTile(
          style: .delta(
            padding: const .add(.symmetric(vertical: 2)),
            contentDecoration: .delta([
              .all(.boxDelta(color: theme.colors.app.transparent)),
            ]),
          ),
          onPress: handleOnPress,
          title: Text(
            title,
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
              fontWeight: .w500,
            ),
          ),
          subtitle: subtitleWidget,
        ),
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Transform.scale(
            scale: .9,
            child: FSwitch(value: value, onChange: onChange),
          ),
        ),
      ],
    );
  }
}

class SettingsSectionTileWithTextSuffix extends SettingsSectionTileWithSuffix {
  const new({
    required super.title,
    required this.suffixText,
    required this.onPress,
    this.subtitle,
    super.key,
  });

  final String suffixText;
  final String? subtitle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final subtitleWidget = subtitle == null
        ? null
        : Text(
            subtitle!,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.mutedForeground,
            ),
          );

    return FTile(
      style: .delta(
        contentDecoration: .delta([
          .all(.boxDelta(color: theme.colors.app.transparent)),
        ]),
      ),
      title: Text(
        title,
        style: theme.typography.body.xs.copyWith(
          color: theme.colors.foreground,
          fontWeight: .w500,
        ),
      ),
      subtitle: subtitleWidget,
      onPress: onPress,
      suffix: Row(
        mainAxisSize: .min,
        spacing: Spacing.sm,
        children: [
          Text(
            suffixText,
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
          Icon(
            FLucideIcons.chevronRight,
            size: 18,
            color: theme.colors.mutedForeground,
          ),
        ],
      ),
    );
  }
}
