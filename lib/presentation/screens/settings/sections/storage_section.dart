import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/settings_controller.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_download_destination_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/confirmation_clear_cache_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

class StorageSection extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(settingsControllerProvider);
    final appConfigController = ref.watch(settingsControllerProvider.notifier);

    final downloadDestination = appConfig.value?.downloadDestinationPath ?? '/';

    final cacheSizeBytes = useState<int>(0);

    useEffect(() {
      cacheSizeBytes.value = appConfigController.getCacheSize();
      return null;
    }, const []);

    Future<void> handleOnSaveDownloadDestination({required String path}) async {
      await appConfigController.setDownloadDestinationPath(path: path);
    }

    Future<void> handleOnConfirmClearCache() async {
      await appConfigController.clearCache();
      cacheSizeBytes.value = appConfigController.getCacheSize();
      if (context.mounted) {
        showFToast(
          context: context,
          title: const Text('Cache cleared successfully'),
        );
      }
    }

    Future<void> handleOnPressDownloadDestination() async {
      await showChangeDownloadDestinationSheet(
        context,
        currentPath: downloadDestination,
        onSaved: (path) => handleOnSaveDownloadDestination(path: path),
      );
    }

    Future<void> handleOnPressClearCache() async {
      await showConfirmationClearCacheSheet(
        context,
        onConfirm: handleOnConfirmClearCache,
      );
    }

    return SettingsSection(
      title: 'Storage',
      children: [
        SettingsSectionTileWithTextSuffix(
          onPress: handleOnPressDownloadDestination,
          title: 'Download destination',
          subtitle: 'on $downloadDestination',
          suffixText: 'Change',
        ),
        SettingsSectionTileWithTextSuffix(
          onPress: handleOnPressClearCache,
          title: 'Clear cache',
          suffixText: formatFileSize(bytes: cacheSizeBytes.value),
        ),
      ],
    );
  }
}
