import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_file_item_card.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_empty_state.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_sheet_header.dart';
import 'package:sharehop/presentation/overlays/share/widgets/selected_files/selected_files_summary_bar.dart';
import 'package:sharehop/presentation/theme/spacing.dart';
import 'package:sharehop/presentation/utils/file_size_formatter.dart';

Future<void> showSelectedFilesSheet(
  BuildContext context, {
  required List<SharedFileInfo> files,
  List<SharedFileInfo> excludedFiles = const [],
  ValueChanged<SharedFileInfo>? onExcludeFile,
  ValueChanged<SharedFileInfo>? onIncludeFile,
  VoidCallback? onClose,
}) async {
  await showFSheet<void>(
    context: context,
    side: .btt,
    onClosing: onClose,
    builder: (sheetContext) => _SelectedFilesSheet(
      initialFiles: files,
      initialExcludedFiles: excludedFiles,
      onExcludeFile: onExcludeFile,
      onIncludeFile: onIncludeFile,
      onClose: onClose,
    ),
  );
  onClose?.call();
}

typedef SelectedFilesSheet = _SelectedFilesSheet;

class _SelectedFilesSheet extends HookWidget {
  const new({
    required this.initialFiles,
    this.initialExcludedFiles = const [],
    this.onExcludeFile,
    this.onIncludeFile,
    this.onClose,
  });

  final List<SharedFileInfo> initialFiles;
  final List<SharedFileInfo> initialExcludedFiles;
  final ValueChanged<SharedFileInfo>? onExcludeFile;
  final ValueChanged<SharedFileInfo>? onIncludeFile;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final activeFiles = useState<List<SharedFileInfo>>(initialFiles);
    final excludedFiles = useState<List<SharedFileInfo>>(initialExcludedFiles);

    void handleOnPressExclude(SharedFileInfo file) {
      activeFiles.value = activeFiles.value.where((f) => f != file).toList();
      excludedFiles.value = [...excludedFiles.value, file];
      onExcludeFile?.call(file);
    }

    void handleOnPressInclude(SharedFileInfo file) {
      excludedFiles.value = excludedFiles.value
          .where((f) => f != file)
          .toList();
      activeFiles.value = [...activeFiles.value, file];
      onIncludeFile?.call(file);
    }

    void handleOnPressExcludeAll() {
      final toExclude = List<SharedFileInfo>.from(activeFiles.value);
      activeFiles.value = const [];
      excludedFiles.value = [...excludedFiles.value, ...toExclude];
      if (onExcludeFile != null) {
        toExclude.forEach(onExcludeFile!);
      }
    }

    void handleOnPressIncludeAll() {
      final toInclude = List<SharedFileInfo>.from(excludedFiles.value);
      excludedFiles.value = const [];
      activeFiles.value = [...activeFiles.value, ...toInclude];
      if (onIncludeFile != null) {
        toInclude.forEach(onIncludeFile!);
      }
    }

    final totalActiveBytes = activeFiles.value.fold<int>(
      0,
      (sum, f) => sum + f.size,
    );
    final totalActiveFormatted = formatFileSize(bytes: totalActiveBytes);

    return Container(
      width: double.maxFinite,
      padding: .symmetric(
        vertical: 2 * theme.style.pagePadding.top,
        horizontal: theme.style.pagePadding.left,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        border: .all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius.xl,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: Spacing.md,
          children: [
            SelectedFilesSheetHeader(fileCount: activeFiles.value.length),
            if (activeFiles.value.isNotEmpty || excludedFiles.value.isNotEmpty)
              SelectedFilesSummaryBar(
                activeCount: activeFiles.value.length,
                activeFormattedSize: totalActiveFormatted,
                excludedCount: excludedFiles.value.length,
                onExcludeAll: handleOnPressExcludeAll,
                onIncludeAll: handleOnPressIncludeAll,
              ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  spacing: Spacing.sm,
                  children: [
                    if (activeFiles.value.isEmpty)
                      SelectedFilesEmptyState(
                        hasExcludedFiles: excludedFiles.value.isNotEmpty,
                        onRestoreAll: handleOnPressIncludeAll,
                      )
                    else ...[
                      if (excludedFiles.value.isNotEmpty)
                        Text(
                          'Included (${activeFiles.value.length})',
                          style: theme.typography.body.xs2.copyWith(
                            color: theme.colors.mutedForeground,
                            fontWeight: .w700,
                          ),
                        ),
                      for (final file in activeFiles.value)
                        SelectedFileItemCard(
                          key: ValueKey(file.name),
                          file: file,
                          isExcluded: false,
                          onActionPress: () => handleOnPressExclude(file),
                        ),
                    ],
                    if (excludedFiles.value.isNotEmpty) ...[
                      Padding(
                        padding: const .only(top: Spacing.xs),
                        child: FDivider(
                          style: .delta(
                            color: theme.colors.border,
                            padding: const .value(
                              .symmetric(vertical: Spacing.xs),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Excluded (${excludedFiles.value.length})',
                            style: theme.typography.body.xs2.copyWith(
                              color: theme.colors.mutedForeground,
                              fontWeight: .w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: handleOnPressIncludeAll,
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              'Include all',
                              style: theme.typography.body.xs2.copyWith(
                                color: theme.colors.primary,
                                fontWeight: .w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (final file in excludedFiles.value)
                        SelectedFileItemCard(
                          key: ValueKey(file.name),
                          file: file,
                          isExcluded: true,
                          onActionPress: () => handleOnPressInclude(file),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
