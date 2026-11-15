import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/errors/app.dart';
import 'package:sharehop/presentation/controllers/add_connection_controller.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/forms/save_connection_button.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/connection_group.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/credential_group.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/security_group.dart';

class WebDavForm extends HookConsumerWidget {
  const new({
    this.connection,
    this.onSuccess,
    this.initialDisplayName,
    this.initialRemoteAddress,
    this.initialRootPath,
    this.initialUsername,
    this.initialPassword,
    super.key,
  });

  final ConnectionViewModel? connection;
  final ValueChanged<ConnectionViewModel>? onSuccess;
  final String? initialDisplayName;
  final String? initialRemoteAddress;
  final String? initialRootPath;
  final String? initialUsername;
  final String? initialPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final displayNameController = useTextEditingController(
      text: connection?.displayName ?? initialDisplayName ?? '',
    );
    final remoteAddressController = useTextEditingController(
      text: connection?.remoteAddress ?? initialRemoteAddress ?? '',
    );
    final rootPathController = useTextEditingController(
      text: connection?.rootPath ?? initialRootPath ?? '/',
    );
    final usernameController = useTextEditingController(
      text: connection?.username ?? initialUsername ?? '',
    );
    final passwordController = useTextEditingController(
      text: connection?.password ?? initialPassword ?? '',
    );
    final validateCertificate = useState<bool>(true);
    final allowSelfSigned = useState<bool>(
      connection?.allowSelfSignedCertificate ?? false,
    );
    final authenticationMethodTabController = useFTabController(
      length: kWebDavFormSecurityAuthenticationMethods.length,
    );

    final connectionState = ref.watch(addConnectionControllerProvider);
    final isLoading = connectionState.isLoading;

    void handleOnChangeValidateCertificate({required bool value}) {
      validateCertificate.value = value;
    }

    void handleOnChangeAllowSelfSigned({required bool value}) {
      allowSelfSigned.value = value;
    }

    Future<void> handleOnPressSave() async {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        return;
      }

      final remoteAddress = remoteAddressController.text.trim();
      final rootPath = rootPathController.text.trim();
      final username = usernameController.text.trim();
      final password = passwordController.text;
      final displayName = displayNameController.text.trim().isNotEmpty
          ? displayNameController.text.trim()
          : null;
      final allowSelfSignedCertificate = allowSelfSigned.value;

      try {
        final notifier = ref.read(addConnectionControllerProvider.notifier);
        final ConnectionViewModel saved;

        if (connection != null) {
          saved = await notifier.updateWebDavConnection(
            id: connection!.id,
            remoteAddress: remoteAddress,
            rootPath: rootPath,
            username: username,
            password: password,
            displayName: displayName,
            isPinned: connection!.isPinned,
            allowSelfSignedCertificate: allowSelfSignedCertificate,
          );
        } else {
          saved = await notifier.addWebDavConnection(
            remoteAddress: remoteAddress,
            rootPath: rootPath,
            username: username,
            password: password,
            displayName: displayName,
            allowSelfSignedCertificate: allowSelfSignedCertificate,
          );
        }

        if (context.mounted) {
          onSuccess?.call(saved);
          context.navigator.pop();
        }
      } on Exception catch (e) {
        if (context.mounted) {
          final errorMessage = e is AppError
              ? e.message
              : 'Failed to save connection';
          showFToast(
            context: context,
            title: const Text('Operation failed'),
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
          WebDavFormConnectionGroup(
            displayNameController: displayNameController,
            remoteAddressController: remoteAddressController,
            rootPathController: rootPathController,
            enabled: !isLoading,
          ),
          WebDavFormCredentialGroup(
            usernameController: usernameController,
            passwordController: passwordController,
            enabled: !isLoading,
          ),
          WebDavFormSecurityGroup(
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
          SaveConnectionButton(
            onPress: handleOnPressSave,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
