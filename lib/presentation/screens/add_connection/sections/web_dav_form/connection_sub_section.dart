import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/text_field.dart';
import 'package:forui_lucide/forui_lucide.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class WebDavFormConnectionSubSection extends StatelessWidget {
  const new({
    this.displayNameController,
    this.remoteAddressController,
    this.rootPathController,
    this.enabled = true,
    super.key,
  });

  final TextEditingController? displayNameController;
  final TextEditingController? remoteAddressController;
  final TextEditingController? rootPathController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      spacing: Spacing.sm,
      children: [
        FTextFormField(
          control: .managed(controller: displayNameController),
          enabled: enabled,
          label: const Text('Display name'),
          hint: 'Example name',
        ),
        FTextFormField(
          control: .managed(controller: remoteAddressController),
          enabled: enabled,
          label: const Text('Server url'),
          hint: 'https://example.com/remote.php/dav',
          description: const Text(
            'Include http:// or https:// and the full WebDAV path supplied by your provider.',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Server url is required'),
            FormBuilderValidators.url(
              protocols: ['http', 'https'],
              requireProtocol: true,
              errorText: 'Server url must be a valid http or https URL',
            ),
          ]),
        ),
        FTextFormField(
          control: .managed(controller: rootPathController),
          enabled: enabled,
          label: const Text('Root path'),
          hint: '/path/to/root',
          prefixBuilder: (_, _, _) => Padding(
            padding: const .only(left: 16, right: 8),
            child: Icon(
              FLucideIcons.folder,
              color: theme.colors.mutedForeground,
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Root path is required'),
            FormBuilderValidators.startsWith(
              '/',
              errorText: 'Root path must start with /',
            ),
          ]),
        ),
      ],
    );
  }
}
