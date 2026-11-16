import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/add_connection/screen.dart';
import 'package:sharehop/presentation/utils/connection_input_parser.dart';

class QuickConnectTextField extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final textController = useTextEditingController();

    void handleOnPressConnect() {
      final input = textController.text.trim();
      final parsed = parseConnectionInput(input: input);

      context.navigator.push(
        MaterialPageRoute<void>(
          builder: (context) => AddConnectionScreen(
            initialProtocol: parsed.protocol,
            initialRemoteAddress: parsed.remoteAddress.isNotEmpty
                ? parsed.remoteAddress
                : null,
            initialRootPath:
                parsed.rootPath.isNotEmpty ? parsed.rootPath : null,
            initialUsername:
                parsed.username.isNotEmpty ? parsed.username : null,
            initialPassword:
                parsed.password.isNotEmpty ? parsed.password : null,
            initialDisplayName: parsed.displayName,
          ),
        ),
      );
    }

    void handleOnSubmitConnect(String _) {
      handleOnPressConnect();
    }

    return FTextField(
      control: .managed(controller: textController),
      style: const .delta(
        contentPadding: .value(EdgeInsetsGeometry.symmetric(vertical: 14)),
      ),
      hint: 'Host or server address',
      onSubmit: handleOnSubmitConnect,
      prefixBuilder: (context, _, _) => Padding(
        padding: const .only(left: 12, right: 8),
        child: Icon(FLucideIcons.link, color: theme.colors.mutedForeground),
      ),
      suffixBuilder: (context, _, _) => Padding(
        padding: const .only(left: 4, right: 10),
        child: IntrinsicWidth(
          child: FButton(
            variant: .secondary,
            size: .xs,
            onPress: handleOnPressConnect,
            child: Text(
              'Connect',
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
