import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_logo.dart';
import 'package:sharehop/presentation/widgets/layout/main_shell.dart';

class SplashScreen extends HookWidget {
  const new({super.key});

  static const _kDuration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnFinish() {
      context.navigator.pushReplacement(
        MaterialPageRoute<void>(builder: (routeContext) => const MainShell()),
      );
    }

    useEffect(() {
      var isMounted = true;

      unawaited(
        Future<void>.delayed(_kDuration).then((_) {
          if (!isMounted || !context.mounted) {
            return;
          }
          handleOnFinish();
        }),
      );

      return () {
        isMounted = false;
      };
    }, [_kDuration]);

    return FScaffold(
      child: SafeArea(
        child: Padding(
          padding: .symmetric(
            horizontal: theme.style.pagePadding.horizontal,
            vertical: theme.style.pagePadding.vertical,
          ),
          child: const Column(
            children: [Spacer(), SplashLogo(), Spacer(), SplashFooter()],
          ),
        ),
      ),
    );
  }
}
