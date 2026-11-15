import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_locked_footer.dart';
import 'package:sharehop/presentation/screens/splash/widgets/splash_logo.dart';
import 'package:sharehop/presentation/widgets/layout/main_shell.dart';

class SplashScreen extends HookConsumerWidget {
  const new({super.key});

  static const _kDuration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isLocked = useState<bool>(false);
    final isAuthenticating = useState<bool>(false);

    Future<void> handleAuthenticateAndNavigate() async {
      isAuthenticating.value = true;
      try {
        final controller = ref.read(settingsControllerProvider.notifier);
        final config = await controller.getAppConfig();
        if (config.isBiometricLockEnabled) {
          final isSupported = await controller.checkBiometricSupported();
          if (isSupported) {
            final authenticated = await controller.authenticateBiometric(
              localizedMessage: 'Authenticate to open ShareHop',
            );

            if (!authenticated) {
              isLocked.value = true;
              return;
            }
          }
        }
      } on Object {
        isLocked.value = true;
        return;
      } finally {
        isAuthenticating.value = false;
      }

      if (!context.mounted) {
        return;
      }

      context.navigator.pushReplacement(
        MaterialPageRoute<void>(builder: (routeContext) => const MainShell()),
      );
    }

    void handleOnPressUnlock() {
      unawaited(handleAuthenticateAndNavigate());
    }

    useEffect(() {
      var isMounted = true;

      unawaited(
        Future<void>.delayed(_kDuration).then((_) async {
          if (!isMounted || !context.mounted) {
            return;
          }
          await handleAuthenticateAndNavigate();
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
          child: Column(
            children: [
              const Spacer(),
              const SplashLogo(),
              const Spacer(),
              Builder(
                builder: (context) {
                  if (isLocked.value) {
                    return SplashLockedFooter(
                      isLoading: isAuthenticating.value,
                      onPressUnlock: handleOnPressUnlock,
                    );
                  }
                  return const SplashFooter();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
