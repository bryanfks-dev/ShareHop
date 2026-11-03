import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/switch.dart';
import 'package:forui/widgets/tabs.dart';
import 'package:forui/widgets/tile.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/theme/theme.dart';

const kWebDavFormSecurityAuthenticationMethods = [
  _WebDavFormSecurityAuthenticationMethodTabValue(
    label: 'Auto',
    description:
        'Auto negotiates a supported authentication method with the server.',
  ),
  _WebDavFormSecurityAuthenticationMethodTabValue(
    label: 'Basic',
    description:
        'Basic sends credentials encoded, not encrypted. HTTPS is '
        'required to protect them in transit.',
  ),
  _WebDavFormSecurityAuthenticationMethodTabValue(
    label: 'Digest',
    description:
        'Digest uses a server challenge-response. HTTPS is required for '
        'transport security.',
  ),
];

class WebDavFormSecuritySubSection extends StatelessWidget {
  const new({
    this.authenticationMethodTabController,
    this.validateCertificate = true,
    this.allowSelfSigned = false,
    this.onValidateCertificateChanged,
    this.onAllowSelfSignedChanged,
    this.enabled = true,
    super.key,
  });

  final FTabController? authenticationMethodTabController;
  final bool validateCertificate;
  final bool allowSelfSigned;
  final ValueChanged<bool>? onValidateCertificateChanged;
  final ValueChanged<bool>? onAllowSelfSignedChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnChangeValidateCertificate({required bool value}) {
      onValidateCertificateChanged?.call(value);
    }

    void handleOnPressValidateCertificate() {
      onValidateCertificateChanged?.call(!validateCertificate);
    }

    void handleOnChangeAllowSelfSigned({required bool value}) {
      onAllowSelfSignedChanged?.call(value);
    }

    void handleOnPressAllowSelfSigned() {
      onAllowSelfSignedChanged?.call(!allowSelfSigned);
    }

    final authenticationMethodEntries = kWebDavFormSecurityAuthenticationMethods
        .map((value) {
          return _WebDavFormSecurityAuthenticationMethodTabEntry(context)
              .entry(value);
        })
        .toList();

    return Column(
      spacing: Spacing.sm,
      children: [
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.xs,
          children: [
            Text(
              'Authentication method',
              style: theme.typography.body.xs.copyWith(fontWeight: .w500),
            ),
            FTabs(
              control: .managed(controller: authenticationMethodTabController),
              style: .delta(
                labelTextStyle: .delta([
                  .all(
                    .delta(
                      fontSize: theme.typography.body.xs.fontSize,
                      fontWeight: .w500,
                    ),
                  ),
                  .match({
                    FTabVariant.selected,
                  }, .delta(color: theme.colors.primary, fontWeight: .w600)),
                ]),
                decoration: .boxDelta(
                  border: Border.all(color: theme.colors.border),
                ),
                indicatorDecoration: .boxDelta(
                  border: Border.all(color: theme.colors.primary),
                ),
              ),
              children: authenticationMethodEntries,
            ),
          ],
        ),
        FTile(
          style: .delta(
            contentDecoration: .delta([
              .all(.boxDelta(color: theme.colors.app.transparent)),
            ]),
            contentStyle: .delta(
              titleTextStyle: .delta([
                .all(
                  .delta(
                    fontSize: theme.typography.body.xs.fontSize,
                    fontWeight: .w600,
                  ),
                ),
              ]),
              subtitleTextStyle: .delta([
                .all(.delta(fontSize: theme.typography.body.xs2.fontSize)),
              ]),
            ),
          ),
          enabled: enabled,
          title: const Text('Validate server certificate'),
          subtitle: const Text('Reject expired or mismatched certificates'),
          suffix: FSwitch(
            value: validateCertificate,
            onChange: (val) => handleOnChangeValidateCertificate(value: val),
          ),
          onPress: handleOnPressValidateCertificate,
        ),
        FTile(
          style: .delta(
            contentDecoration: .delta([
              .all(.boxDelta(color: theme.colors.app.warning)),
            ]),
            contentStyle: .delta(
              titleTextStyle: .delta([
                .all(
                  .delta(
                    fontSize: theme.typography.body.xs.fontSize,
                    fontWeight: .w600,
                  ),
                ),
              ]),
              subtitleTextStyle: .delta([
                .all(.delta(fontSize: theme.typography.body.xs2.fontSize)),
              ]),
            ),
          ),
          enabled: enabled,
          title: const Text('Allow self-signed certificate'),
          subtitle: const Text('Only enable for a server you trust'),
          suffix: FSwitch(
            value: allowSelfSigned,
            onChange: (val) => handleOnChangeAllowSelfSigned(value: val),
          ),
          onPress: handleOnPressAllowSelfSigned,
        ),
      ],
    );
  }
}

class _WebDavFormSecurityAuthenticationMethodTabEntry {
  const new(this.context);

  final BuildContext context;

  FTabEntry entry(_WebDavFormSecurityAuthenticationMethodTabValue value) {
    final theme = context.theme;

    return FTabEntry.entry(
      label: Text(value.label),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Text(
              value.description,
              style: theme.typography.body.xs2.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WebDavFormSecurityAuthenticationMethodTabValue {
  const new({required this.label, required this.description});

  final String label;
  final String description;
}
