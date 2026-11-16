import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/text_field.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class WebDavFormCredentialGroup extends StatelessWidget {
  const new({
    this.usernameController,
    this.passwordController,
    this.enabled = true,
    super.key,
  });

  final TextEditingController? usernameController;
  final TextEditingController? passwordController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      spacing: Spacing.sm,
      children: [
        FTextFormField(
          control: .managed(controller: usernameController),
          enabled: enabled,
          prefixBuilder: (_, _, _) => Padding(
            padding: const .only(left: 16, right: 8),
            child: Icon(FLucideIcons.user, color: theme.colors.mutedForeground),
          ),
          label: Text(
            'Username',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
            ),
          ),
          hint: 'Example username',
        ),
        FTextFormField.password(
          control: .managed(controller: passwordController),
          prefixBuilder: (_, _, _, _) => Padding(
            padding: const .only(left: 16, right: 8),
            child: Icon(
              FLucideIcons.keyRound,
              color: theme.colors.mutedForeground,
            ),
          ),
          enabled: enabled,
          label: Text(
            'Password or app password',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
            ),
          ),
          hint: '••••••••••••',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Password or app password is required',
            ),
          ]),
        ),
      ],
    );
  }
}
