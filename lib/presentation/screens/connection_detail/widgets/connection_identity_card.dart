import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/connection_information_sheet.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ConnectionIdentityCard extends StatelessWidget {
  const new({required this.connection, super.key});

  final ConnectionViewModel connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Future<void> handleOnPressInfo() async {
      await showConnectionInformationSheet(context, connection: connection);
    }

    return FCard(
      builder: (cardContext, style, _) {
        return Padding(
          padding: style.padding,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  spacing: Spacing.lg,
                  children: [
                    ConnectionProtocolGlyph(
                      connectionProtocol: connection.protocol,
                      size: 52,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        spacing: Spacing.xs2,
                        children: [
                          Text(
                            connection.displayName,
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: theme.typography.body.xs.copyWith(
                              color: theme.colors.foreground,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            connection.remoteAddress,
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: theme.typography.body.xs2.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FButton(
                onPress: handleOnPressInfo,
                variant: .ghost,
                child: Icon(
                  FLucideIcons.info,
                  size: 20,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
