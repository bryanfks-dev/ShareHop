import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/errors/app.dart';
import 'package:sharehop/presentation/controllers/add_connection_controller.dart';
import 'package:sharehop/presentation/router/navigator_extension.dart';
import 'package:sharehop/presentation/screens/add_connection/sections/web_dav_form/connection_sub_section.dart';
import 'package:sharehop/presentation/screens/add_connection/sections/web_dav_form/credential_sub_section.dart';
import 'package:sharehop/presentation/screens/add_connection/sections/web_dav_form/security_sub_section.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/test_and_save_connection_button.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class WebDavFormSection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final displayNameController = useTextEditingController();
    final serverUrlController = useTextEditingController();
    final rootPathController = useTextEditingController(text: '/');
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final validateCertificate = useState<bool>(true);
    final allowSelfSigned = useState<bool>(false);
    final authenticationMethodTabController = useFTabController(
      length: kWebDavFormSecurityAuthenticationMethods.length,
    );

    final addConnectionState = ref.watch(addConnectionControllerProvider);
    final isLoading = addConnectionState.isLoading;

    void handleOnChangeValidateCertificate({required bool value}) {
      validateCertificate.value = value;
    }

    void handleOnChangeAllowSelfSigned({required bool value}) {
      allowSelfSigned.value = value;
    }

    Future<void> handleOnPressTestAndSave() async {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        return;
      }

      try {
        await ref
            .read(addConnectionControllerProvider.notifier)
            .addWebDavConnection(
              serverUrl: serverUrlController.text.trim(),
              rootPath: rootPathController.text.trim(),
              username: usernameController.text.trim(),
              password: passwordController.text,
              displayName: displayNameController.text.trim().isNotEmpty
                  ? displayNameController.text.trim()
                  : null,
            );

        if (context.mounted) {
          showFToast(
            context: context,
            title: const Text('Connection saved successfully'),
          );
          context.navigator.pop();
        }
      } on Exception catch (e) {
        if (context.mounted) {
          final errorMessage = e is AppError
              ? e.message
              : 'Failed to connect to server';
          showFToast(
            context: context,
            title: const Text('Connection failed'),
            description: Text(errorMessage),
          );
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        spacing: Spacing.lg,
        mainAxisSize: .min,
        children: [
          WebDavFormConnectionSubSection(
            displayNameController: displayNameController,
            serverUrlController: serverUrlController,
            rootPathController: rootPathController,
            enabled: !isLoading,
          ),
          WebDavFormCredentialSubSection(
            usernameController: usernameController,
            passwordController: passwordController,
            enabled: !isLoading,
          ),
          WebDavFormSecuritySubSection(
            authenticationMethodTabController:
                authenticationMethodTabController,
            validateCertificate: validateCertificate.value,
            allowSelfSigned: allowSelfSigned.value,
            onValidateCertificateChanged: (val) =>
                handleOnChangeValidateCertificate(value: val),
            onAllowSelfSignedChanged: (val) =>
                handleOnChangeAllowSelfSigned(value: val),
            enabled: !isLoading,
          ),
          TestAndSaveConnectionButton(
            onPress: handleOnPressTestAndSave,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
