import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

class QuickConnectTextField extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final textController = useTextEditingController();

    void handleOnPressConnect() {}

    return FTextField(
      control: .managed(controller: textController),
      style: const .delta(
        contentPadding: .value(EdgeInsetsGeometry.symmetric(vertical: 14)),
      ),
      hint: 'Host or server address',
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
            child: const Text('Connect'),
          ),
        ),
      ),
    );
  }
}
