import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/landspace_workspace_handoff/widgets/landspace_workspace_handoff_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/primitives/scroll_down_button.dart';

class LandspaceWorkspaceHandoffScreen extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final scrollController = useScrollController();

    void handleOnPressOpenWorkspace() {}

    void handleOnPressNotNow() {
      context.navigator.pop();
    }

    return FScaffold(
      header: const LandspaceWorkspaceHandoffHeader(),
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
              controller: scrollController,
              child: Center(
                child: Column(
                  spacing: Spacing.lg,
                  children: [
                    Column(
                      spacing: Spacing.sm,
                      children: [
                        SvgPicture.asset(
                          'assets/images/orientation_illustration.svg',
                        ),
                        Text(
                          'Turn your Phone. Work both sides.',
                          textAlign: .center,
                          style: theme.typography.display.xl.copyWith(
                            color: theme.colors.foreground,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'ShareHop will rotate to show Device on the left and '
                          'Production on the right, while preserving your '
                          'current connection context.',
                          textAlign: .center,
                          style: theme.typography.body.xs.copyWith(
                            color: theme.colors.mutedForeground,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    FTileGroup(
                      divider: .none,
                      children: [
                        FTile(
                          prefix: Container(
                            width: theme.style.sizes.field.sm,
                            height: theme.style.sizes.field.sm,
                            decoration: BoxDecoration(
                              color: theme.colors.secondary,
                              borderRadius: theme.style.borderRadius.md,
                            ),
                            child: const Icon(
                              FLucideIcons.smartphone,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'Device stays on the left',
                            style: theme.typography.body.sm.copyWith(
                              color: theme.colors.foreground,
                            ),
                          ),
                          subtitle: Text(
                            'Pick local files without leaving the workspace.',
                            style: theme.typography.body.xs2.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                          ),
                        ),
                        FTile(
                          prefix: Container(
                            width: theme.style.sizes.field.sm,
                            height: theme.style.sizes.field.sm,
                            decoration: BoxDecoration(
                              color: theme.colors.secondary,
                              borderRadius: theme.style.borderRadius.md,
                            ),
                            child: const Icon(FLucideIcons.server, size: 20),
                          ),
                          title: Text(
                            'Production stays on the right',
                            style: theme.typography.body.sm.copyWith(
                              color: theme.colors.foreground,
                            ),
                          ),
                          subtitle: Text(
                            'Your secure session and path remain open.',
                            style: theme.typography.body.xs2.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                          ),
                        ),
                        FTile(
                          prefix: Container(
                            width: theme.style.sizes.field.sm,
                            height: theme.style.sizes.field.sm,
                            decoration: BoxDecoration(
                              color: theme.colors.secondary,
                              borderRadius: theme.style.borderRadius.md,
                            ),
                            child: const Icon(
                              FLucideIcons.arrowLeftRight,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'Transfer in either direction',
                            style: theme.typography.body.sm.copyWith(
                              color: theme.colors.foreground,
                            ),
                          ),
                          subtitle: Text(
                            'Select items, review size, then move them with '
                            'one action.',
                            style: theme.typography.body.xs2.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: Spacing.sm,
                      children: [
                        FButton(
                          size: .lg,
                          onPress: handleOnPressOpenWorkspace,
                          prefix: const Icon(FLucideIcons.columns2),
                          child: Text(
                            'Open landspace workspace',
                            style: theme.typography.body.md.copyWith(
                              color: theme.colors.primaryForeground,
                            ),
                          ),
                        ),
                        FButton(
                          size: .lg,
                          style: .delta(
                            contentStyle: .delta(
                              textStyle: .delta([
                                .all(
                                  .delta(
                                    color: theme.colors.mutedForeground,
                                    fontWeight: .w400,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          onPress: handleOnPressNotNow,
                          variant: .ghost,
                          child: Text(
                            'Not now',
                            style: theme.typography.body.md.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ScrollDownButton(scrollController: scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
