import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Future<void> showInformationFeatureNotAvailableSheet(
  BuildContext context,
) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    builder: (sheetContext) =>
        const _InformationFeatureNotAvailableSheetContent(),
  );
}

class _InformationFeatureNotAvailableSheetContent extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPress() {
      context.navigator.pop();
    }

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: Spacing.lg,
            children: [
              Text(
                'Feature Not Available',
                style: theme.typography.display.sm.copyWith(
                  color: theme.colors.foreground,
                  fontWeight: .w600,
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/feature_not_available_illustration.svg',
                  height: theme.style.sheetIllustrationHeight,
                ),
              ),
              Text(
                'This feature is not available yet. '
                'Please ask the developer to implement it.',
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  FButton(
                    size: .sm,
                    onPress: handleOnPress,
                    child: Text(
                      'OK',
                      style: theme.typography.body.xs.copyWith(
                        color: theme.colors.primaryForeground,
                        fontWeight: .w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
