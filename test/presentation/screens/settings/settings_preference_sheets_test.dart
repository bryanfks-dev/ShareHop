import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/app_theme.dart';
import 'package:sharehop/core/enums/file_conflicts_resolution.dart';
import 'package:sharehop/core/models/app_config_model.dart';
import 'package:sharehop/core/repositories/app_config_repository.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_app_appearance_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_download_destination_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_on_file_conflicts_resolution_sheet.dart';
import 'package:sharehop/presentation/screens/settings/widgets/change_simultaneous_transfers_limit_sheet.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class _FakeAppConfigRepository implements AppConfigRepository {
  AppConfigModel model = AppConfigModel(
    isWifiOnlyTransfersEnabled: true,
    isBackgroundTransfersEnabled: false,
    simultaneousTransfersLimit: 3,
    onFileConflictsResolution: FileConflictsResolution.askeverytime,
    isBiometricLockEnabled: false,
    downloadDestinationPath: '/downloads/test',
    appAppearance: AppTheme.system,
  );

  @override
  Future<AppConfigModel> getConfig() async => model;

  @override
  Future<String> getEncryptionKey() async => 'test-key';

  @override
  Future<void> setAppTheme({required AppTheme theme}) async {
    model = model.copyWith(appAppearance: theme);
  }

  @override
  Future<void> setDownloadPath({required String path}) async {
    model = model.copyWith(downloadDestinationPath: path);
  }

  @override
  Future<void> setBackgroundTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isBackgroundTransfersEnabled: enabled);
  }

  @override
  Future<void> setBiometricLockEnabled({required bool enabled}) async {
    model = model.copyWith(isBiometricLockEnabled: enabled);
  }

  @override
  Future<void> setWifiOnlyTransfersEnabled({required bool enabled}) async {
    model = model.copyWith(isWifiOnlyTransfersEnabled: enabled);
  }

  @override
  Future<void> setFileConflictResolution({
    required FileConflictsResolution resolution,
  }) async {
    model = model.copyWith(onFileConflictsResolution: resolution);
  }

  @override
  Future<void> setMaxSimultaneousTransfers({required int limit}) async {
    model = model.copyWith(simultaneousTransfersLimit: limit);
  }
}

Widget _buildTestWidget({
  required WidgetBuilder builder,
  required _FakeAppConfigRepository repo,
}) {
  return ProviderScope(
    overrides: [appConfigRepositoryProvider.overrideWithValue(repo)],
    child: MaterialApp(
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (context, c) => FTheme(
        data: lightTheme,
        child: FToaster(child: c!),
      ),
      home: Scaffold(
        body: Builder(builder: builder),
      ),
    ),
  );
}

void main() {
  group('Settings Preference Sheets', () {
    late _FakeAppConfigRepository repo;

    setUp(() {
      repo = _FakeAppConfigRepository();
    });

    testWidgets('showChangeAppAppearanceSheet opens and selects dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          repo: repo,
          builder: (context) => FButton(
            onPress: () => showChangeAppAppearanceSheet(context),
            child: const Text('Open Appearance'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Appearance'));
      await tester.pumpAndSettle();

      expect(find.text('Select app appearance'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('System'), findsOneWidget);

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(repo.model.appAppearance, AppTheme.dark);
    });

    testWidgets('showChangeDownloadDestinationSheet saves updated path', (
      tester,
    ) async {
      String? savedPath;

      await tester.pumpWidget(
        _buildTestWidget(
          repo: repo,
          builder: (context) => FButton(
            onPress: () => showChangeDownloadDestinationSheet(
              context,
              currentPath: '/old/path',
              onSave: (path) => savedPath = path,
            ),
            child: const Text('Open Destination'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Destination'));
      await tester.pumpAndSettle();

      expect(find.text('Download Destination'), findsOneWidget);

      final editables = find.byType(EditableText);
      await tester.enterText(editables.first, '/new/downloads');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(savedPath, equals('/new/downloads'));
    });

    testWidgets(
      'showChangeOnFileConflictsResolutionSheet opens and selects overwrite',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            repo: repo,
            builder: (context) => FButton(
              onPress: () =>
                  showChangeOnFileConflictsResolutionSheet(context),
              child: const Text('Open Conflicts'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Conflicts'));
        await tester.pumpAndSettle();

        expect(find.text('Select file conflicts resolution'), findsOneWidget);
        expect(find.text('Overwrite files'), findsOneWidget);

        await tester.tap(find.text('Overwrite files'));
        await tester.pumpAndSettle();

        expect(
          repo.model.onFileConflictsResolution,
          FileConflictsResolution.overwrite,
        );
      },
    );

    testWidgets(
      'showChangeSimultaneousTransfersLimitSheet updates transfers limit',
      (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            repo: repo,
            builder: (context) => FButton(
              onPress: () =>
                  showChangeSimultaneousTransfersLimitSheet(context),
              child: const Text('Open Limits'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Open Limits'));
        await tester.pumpAndSettle();

        expect(
          find.text('Select simultaneous transfers limit'),
          findsOneWidget,
        );

        await tester.tap(find.text('5 transfer(s)'));
        await tester.pumpAndSettle();

        expect(repo.model.simultaneousTransfersLimit, 5);
      },
    );
  });
}
