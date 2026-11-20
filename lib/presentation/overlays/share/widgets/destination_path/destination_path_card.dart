import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_path/destination_path_picker_sheet.dart';
import 'package:sharehop/presentation/theme/spacing.dart';

class DestinationPathCard extends HookWidget {
  const new({required this.path, this.onBrowse, this.onPathChanged, super.key});

  final String path;
  final VoidCallback? onBrowse;
  final ValueChanged<String>? onPathChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final currentPath = useState<String>(path);

    useEffect(() {
      currentPath.value = path;
      return null;
    }, [path]);

    Future<void> handleOnPressBrowse() async {
      onBrowse?.call();
      final newPath = await showDestinationPathPickerSheet(
        context,
        initialPath: currentPath.value,
      );
      if (context.mounted && newPath != null && newPath.isNotEmpty) {
        currentPath.value = newPath;
        onPathChanged?.call(newPath);
      }
    }

    return Container(
      width: double.infinity,
      padding: const .symmetric(horizontal: Spacing.md, vertical: Spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.card,
        borderRadius: theme.style.borderRadius.xl,
        border: .all(color: theme.colors.border),
      ),
      child: Row(
        spacing: Spacing.sm,
        children: [
          Icon(FLucideIcons.folder, size: 18, color: theme.colors.primary),
          Expanded(
            child: Text(
              currentPath.value,
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.foreground,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
          FButton(
            size: .xs,
            variant: .ghost,
            onPress: handleOnPressBrowse,
            child: Text(
              'Browse',
              style: theme.typography.body.xs.copyWith(
                color: theme.colors.primary,
                fontWeight: .w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
