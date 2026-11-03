import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/widgets/scaffold.dart';
import 'package:sharehop/presentation/enums/navigation_tab.dart';
import 'package:sharehop/presentation/screens/connections_home/screen.dart';
import 'package:sharehop/presentation/screens/settings/screen.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/screen.dart';
import 'package:sharehop/presentation/widgets/layout/footer.dart';

class MainShell extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNavigationTab = useState<NavigationTab>(.connections);

    void handleOnChangeNavigationTab({
      required NavigationTab navigationTab,
    }) {
      selectedNavigationTab.value = navigationTab;
    }

    return FScaffold(
      childPad: false,
      footer: Footer(
        selectedNavigationTab: selectedNavigationTab.value,
        onNavigationTabChange: (tab) =>
            handleOnChangeNavigationTab(navigationTab: tab),
      ),
      child: IndexedStack(
        index: NavigationTab.values.indexOf(selectedNavigationTab.value),
        children: const [
          ConnectionsHomeScreen(),
          TransferActivitiesScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
