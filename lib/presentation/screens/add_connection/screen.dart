import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/screens/add_connection/sections/web_dav_form/section.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/add_connection_header.dart';
import 'package:sharehop/presentation/screens/add_connection/widgets/change_connection_protocol/selector.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class AddConnectionScreen extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final selectedConnectionProtocol = useState<ConnectionProtocol>(.webdav);

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
                const WebDavFormSection()
              else
                Padding(
                  padding: .symmetric(
                    horizontal: theme.style.pagePadding.horizontal,
                  ),
                  child: Column(
                    spacing: Spacing.sm,
                    children: [
                      Text(
                        '${selectedConnectionProtocol.value.name} is not '
                        'supported yet',
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
