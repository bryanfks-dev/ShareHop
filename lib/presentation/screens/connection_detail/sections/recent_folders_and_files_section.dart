import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/recent_file_tile.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/recent_folder_tile.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class RecentFoldersAndFilesSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void handleOnPressReleasesFolder() {}
    void handleOnPressAssetsFolder() {}
    void handleOnPressProductDemoFile() {}
    void handleOnPressReleaseNotesFile() {}

    return Column(
      spacing: Spacing.lg,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(
          'RECENT FOLDERS & FILES',
          style: theme.typography.display.xs.copyWith(
            color: theme.colors.foreground,
            fontWeight: .w700,
          ),
        ),
        FTileGroup(
          style: .delta(decoration: .shapeDelta(color: theme.colors.card)),
          divider: .full,
          children: [
            RecentFolderTile(
              name: 'releases',
              subtitle: 'Folder · opened 18 min ago',
              onPress: handleOnPressReleasesFolder,
            ),
            RecentFolderTile(
              name: 'assets',
              subtitle: 'Folder · 22 items',
              onPress: handleOnPressAssetsFolder,
            ),
            RecentFileTile(
              name: 'product-demo-final.mp4',
              subtitle: '184.7 MB · modified today',
              onPress: handleOnPressProductDemoFile,
            ),
            RecentFileTile(
              name: 'release-notes.md',
              subtitle: '6 KB · modified yesterday',
              onPress: handleOnPressReleaseNotesFile,
            ),
          ],
        ),
      ],
    );
  }
}
