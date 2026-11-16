import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class WebDavFormConnectionGroup extends StatefulWidget {
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
  State<WebDavFormConnectionGroup> createState() =>
      _WebDavFormConnectionGroupState();
}

class _WebDavFormConnectionGroupState extends State<WebDavFormConnectionGroup> {
  late String _selectedProtocol;
  late final TextEditingController _urlController;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    final initialRaw = widget.remoteAddressController?.text.trim() ?? '';
    final parsed = _parseUrl(initialRaw);
    _selectedProtocol = parsed.protocol;
    _urlController = TextEditingController(text: parsed.hostAndPath);

    _syncToRemoteAddressController();

    _urlController.addListener(handleOnChangeUrlController);
    widget.remoteAddressController?.addListener(
      handleOnChangeRemoteAddressController,
    );
  }

  @override
  void didUpdateWidget(WebDavFormConnectionGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remoteAddressController != widget.remoteAddressController) {
      oldWidget.remoteAddressController?.removeListener(
        handleOnChangeRemoteAddressController,
      );
      widget.remoteAddressController?.addListener(
        handleOnChangeRemoteAddressController,
      );
      handleOnChangeRemoteAddressController();
    }
  }

  @override
  void dispose() {
    widget.remoteAddressController?.removeListener(
      handleOnChangeRemoteAddressController,
    );
    _urlController
      ..removeListener(handleOnChangeUrlController)
      ..dispose();
    super.dispose();
  }

  ({String protocol, String hostAndPath}) _parseUrl(String raw) {
    final trimmed = raw.trim();
    if (trimmed.startsWith('https://')) {
      return (
        protocol: 'https',
        hostAndPath: trimmed.substring('https://'.length),
      );
    } else if (trimmed.startsWith('http://')) {
      return (
        protocol: 'http',
        hostAndPath: trimmed.substring('http://'.length),
      );
    }
    return (protocol: 'https', hostAndPath: trimmed);
  }

  void _syncToRemoteAddressController() {
    if (widget.remoteAddressController == null) {
      return;
    }
    final hostAndPath = _urlController.text.trim();
    final newFullUrl = hostAndPath.isEmpty
        ? ''
        : '$_selectedProtocol://$hostAndPath';
    if (widget.remoteAddressController!.text != newFullUrl) {
      _isSyncing = true;
      widget.remoteAddressController!.text = newFullUrl;
      _isSyncing = false;
    }
  }

  void handleOnChangeUrlController() {
    if (_isSyncing) {
      return;
    }

    final currentText = _urlController.text;
    if (currentText.startsWith('https://')) {
      final stripped = currentText.substring('https://'.length);
      _isSyncing = true;
      setState(() {
        _selectedProtocol = 'https';
      });
      _urlController.value = TextEditingValue(
        text: stripped,
        selection: TextSelection.collapsed(offset: stripped.length),
      );
      _isSyncing = false;
      _syncToRemoteAddressController();
      return;
    } else if (currentText.startsWith('http://')) {
      final stripped = currentText.substring('http://'.length);
      _isSyncing = true;
      setState(() {
        _selectedProtocol = 'http';
      });
      _urlController.value = TextEditingValue(
        text: stripped,
        selection: TextSelection.collapsed(offset: stripped.length),
      );
      _isSyncing = false;
      _syncToRemoteAddressController();
      return;
    }

    _syncToRemoteAddressController();
  }

  void handleOnChangeRemoteAddressController() {
    if (_isSyncing) {
      return;
    }
    final externalText = widget.remoteAddressController?.text.trim() ?? '';
    final currentFullUrl = _urlController.text.trim().isEmpty
        ? ''
        : '$_selectedProtocol://${_urlController.text.trim()}';

    if (externalText != currentFullUrl) {
      final parsed = _parseUrl(externalText);
      _isSyncing = true;
      setState(() {
        _selectedProtocol = parsed.protocol;
      });
      _urlController.value = TextEditingValue(
        text: parsed.hostAndPath,
        selection: TextSelection.collapsed(offset: parsed.hostAndPath.length),
      );
      _isSyncing = false;
    }
  }

  void handleOnChangeProtocol(String protocol) {
    if (_selectedProtocol == protocol) {
      return;
    }
    setState(() {
      _selectedProtocol = protocol;
    });
    _syncToRemoteAddressController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      spacing: Spacing.sm,
      children: [
        FTextFormField(
          control: .managed(controller: widget.displayNameController),
          enabled: widget.enabled,
          label: Text(
            'Display name',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
            ),
          ),
          hint: 'Example name',
        ),
        FTextFormField(
          control: .managed(controller: _urlController),
          enabled: widget.enabled,
          label: Text(
            'Server url',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
            ),
          ),
          hint: 'example.com/remote.php/dav',
          description: Text(
            'Select the protocol and enter the full WebDAV path '
            'supplied by your provider.',
            style: theme.typography.body.xs2.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
          prefixBuilder: (context, style, variants) => FPopoverMenu(
            menuAnchor: .topLeft,
            childAnchor: .bottomLeft,
            menuBuilder: (context, controller, _) {
              void handleOnPressSelectHttps() {
                unawaited(controller.hide());
                handleOnChangeProtocol('https');
              }

              void handleOnPressSelectHttp() {
                unawaited(controller.hide());
                handleOnChangeProtocol('http');
              }

              return [
                FItemGroup(
                  children: [
                    FItem(
                      title: Text(
                        'https://',
                        style: theme.typography.body.xs.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                      selected: _selectedProtocol == 'https',
                      onPress: handleOnPressSelectHttps,
                    ),
                    FItem(
                      title: Text(
                        'http://',
                        style: theme.typography.body.xs.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                      selected: _selectedProtocol == 'http',
                      onPress: handleOnPressSelectHttp,
                    ),
                  ],
                ),
              ];
            },
            builder: (context, controller, child) => MouseRegion(
              cursor: widget.enabled
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.enabled ? controller.toggle : null,
                child: child,
              ),
            ),
            child: Padding(
              padding: const .only(left: 14, right: 8),
              child: Row(
                mainAxisSize: .min,
                spacing: Spacing.xs,
                children: [
                  Text(
                    '$_selectedProtocol://',
                    style: theme.typography.body.sm.copyWith(
                      color: widget.enabled
                          ? theme.colors.foreground
                          : theme.colors.mutedForeground,
                      fontWeight: .w500,
                    ),
                  ),
                  Icon(
                    FLucideIcons.chevronDown,
                    size: 14,
                    color: theme.colors.mutedForeground,
                  ),
                  Container(width: 1, height: 18, color: theme.colors.border),
                ],
              ),
            ),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Server url is required'),
            (value) {
              if (value == null || value.trim().isEmpty) {
                return null;
              }
              final clean = value.trim().replaceFirst(
                RegExp(r'^https?:\/\/'),
                '',
              );
              final fullUrl = '$_selectedProtocol://$clean';
              return FormBuilderValidators.url(
                protocols: ['http', 'https'],
                requireProtocol: true,
                requireTld: false,
                errorText: 'Server url must be a valid http or https URL',
              )(fullUrl);
            },
          ]),
        ),
        FTextFormField(
          control: .managed(controller: widget.rootPathController),
          enabled: widget.enabled,
          label: Text(
            'Root path',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.foreground,
            ),
          ),
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
