import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/extensions/enums/connection_protocol_extension.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/add_connection_header.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/change_connection_protocol/selector.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/widgets/connection/forms/web_dav/form.dart';

class AddConnectionScreen extends HookWidget {
  const new({
    this.initialProtocol = ConnectionProtocol.webdav,
    this.initialDisplayName,
    this.initialRemoteAddress,
    this.initialRootPath,
    this.initialUsername,
    this.initialPassword,
    super.key,
  });

  final ConnectionProtocol initialProtocol;
  final String? initialDisplayName;
  final String? initialRemoteAddress;
  final String? initialRootPath;
  final String? initialUsername;
  final String? initialPassword;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final selectedConnectionProtocol =
        useState<ConnectionProtocol>(initialProtocol);

    void handleOnChangeConnectionProtocol({
      required ConnectionProtocol connectionProtocol,
    }) {
      selectedConnectionProtocol.value = connectionProtocol;
    }

    return FScaffold(
      header: const AddConnectionHeader(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 2 * theme.style.pagePadding.bottom),
          child: Column(
            spacing: Spacing.xl,
            mainAxisSize: .min,
            children: [
              ChangeConnectionProtocolSelector(
                value: selectedConnectionProtocol.value,
                onChange: (val) =>
                    handleOnChangeConnectionProtocol(connectionProtocol: val),
              ),
              if (selectedConnectionProtocol.value == .webdav)
                WebDavForm(
                  initialDisplayName: initialDisplayName,
                  initialRemoteAddress: initialRemoteAddress,
                  initialRootPath: initialRootPath,
                  initialUsername: initialUsername,
                  initialPassword: initialPassword,
                )
              else
                Padding(
                  padding: .symmetric(
                    horizontal: theme.style.pagePadding.horizontal,
                  ),
                  child: Column(
                    spacing: Spacing.sm,
                    children: [
                      Text(
                        '${selectedConnectionProtocol.value.displayName} '
                        'is not supported yet',
                        style: theme.typography.display.xs.copyWith(
                          fontWeight: .w600,
                        ),
                      ),
                      Text(
                        'Currently only WebDAV protocol is supported. '
                        'Please select WebDAV to configure your connection.',
                        style: theme.typography.body.sm.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                        textAlign: .center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
