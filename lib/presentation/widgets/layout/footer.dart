import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/enums/navigation_tab.dart';

class Footer extends StatelessWidget {
  const new({
    this.selectedNavigationTab = .connections,
    this.onNavigationTabChange,
    super.key,
  });

  final NavigationTab selectedNavigationTab;
  final void Function(NavigationTab)? onNavigationTabChange;

  void handleOnChangeNavigationTab({required int index}) {
    onNavigationTabChange?.call(NavigationTab.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final index = NavigationTab.values.indexOf(selectedNavigationTab);

    return FBottomNavigationBar(
      style: .delta(decoration: .boxDelta(color: theme.colors.card)),
      index: index,
      safeAreaBottom: true,
      onChange: (idx) => handleOnChangeNavigationTab(index: idx),
      children: const [
        FBottomNavigationBarItem(
          icon: Icon(FLucideIcons.server),
          label: Text('Connections'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(FLucideIcons.arrowUpDown),
          label: Text('Transfers'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(FLucideIcons.settings),
          label: Text('Settings'),
        ),
      ],
    );
  }
}
