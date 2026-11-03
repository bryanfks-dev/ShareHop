import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_status.dart';
import 'package:sharehop/core/models/connection_model.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/connection/connection_protocol_glyph.dart';

class ConnectionIdentityCard extends StatelessWidget {
  const new({
    required this.connection,
    this.connectionStatus = .online,
    super.key,
  });

  final ConnectionModel connection;
  final ConnectionStatus connectionStatus;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressInfo() {}

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
                          Row(
                            mainAxisSize: .min,
                            spacing: Spacing.xs,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: theme.colors.app.success,
                                  shape: .circle,
                                ),
                              ),
                              Text(
                                connectionStatus.label,
                                style: theme.typography.body.xs2.copyWith(
                                  color: theme.colors.app.success,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
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
