import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class ApplicationOverlay extends ConsumerWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(settingsControllerProvider);
    final themeData = switch (appConfig.value?.appAppearance) {
      AppTheme.light => lightTheme,
      AppTheme.dark => darkTheme,
      AppTheme.system =>
        Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
      null => Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
    };

    return MaterialApp(
      title: 'ShareHop',
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      theme: lightTheme.toApproximateMaterialTheme().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      darkTheme: darkTheme.toApproximateMaterialTheme().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      builder: (context, child) => FTheme(
        data: themeData,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: child,
    );
  }
}
