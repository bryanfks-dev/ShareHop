import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/scaffold.dart';
import 'package:sharehop/presentation/screens/settings/sections/app_preferences_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/security_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/storage_section.dart';
import 'package:sharehop/presentation/screens/settings/sections/transfer_preferences_section.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_header.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/primitives/trademark.dart';

class SettingsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: const SettingsHeader(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: const Column(
            spacing: Spacing.lg,
            mainAxisSize: .min,
            children: [
              TransferPreferencesSection(),
              SecuritySection(),
              StorageSection(),
              AppPreferencesSection(),
              Trademark(),
            ],
          ),
        ),
      ),
    );
  }
}
