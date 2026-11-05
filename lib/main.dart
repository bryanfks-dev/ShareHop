import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/presentation/controllers/app_config_controller.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/layout/main_shell.dart';

void main() {
  runApp(const ProviderScope(child: Application()));
}

class Application extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigControllerProvider);
    final themeData = switch (appConfig.value?.appAppearance) {
      AppTheme.light => lightTheme,
      AppTheme.dark => darkTheme,
      AppTheme.system =>
        Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
      null => Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
    };

    return MaterialApp(
      title: 'ShareHop',
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      // MaterialApp's theme is also animated by default with the same
      // duration and curve. See
      // https://api.flutter.dev/flutter/material/MaterialApp/themeAnimationStyle.html
      // for how to configure this.
      //
      // There is a known issue with implicitly animated widgets where their
      // transition occurs AFTER the theme's.
      // See https://github.com/duobaseio/forui/issues/670.
      theme: lightTheme.toApproximateMaterialTheme(),
      darkTheme: darkTheme.toApproximateMaterialTheme(),
      builder: (context, child) => FTheme(
        data: themeData,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      // You can also replace FScaffold with Material Scaffold.
      home: const MainShell(),
    );
  }
}
