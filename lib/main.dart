import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sharehop/infrastructures/database/manager.dart';
import 'package:sharehop/presentation/overlays/share/overlay.dart';
import 'package:sharehop/presentation/widgets/application.dart';
import 'package:sharehop/presentation/widgets/application_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    await DatabaseManager.instance.init();
  }

  runApp(const ProviderScope(child: Application()));
}

@pragma('vm:entry-point')
Future<void> shareMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseManager.enableWorkbench = false;
  DatabaseManager.wipeOnDevMode = false;

  if (kDebugMode) {
    await DatabaseManager.instance.init(enableWorkbench: false);
  }

  runApp(const ProviderScope(child: ApplicationOverlay(child: ShareOverlay())));
}
