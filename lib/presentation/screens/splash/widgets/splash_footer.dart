import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/primitives/trademark.dart';

class SplashFooter extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: .min,
      spacing: Spacing.md,
      children: [
        FCircularProgress(size: .sm),
        Trademark(),
      ],
    );
  }
}
