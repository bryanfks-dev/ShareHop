# Flutter ForUI Rules

# Use ForUI

- ALWAYS use ForUI (`forui` package) widgets for UI instead of stock
  Flutter Material/Cupertino widgets.
  - Use `FButton` instead of `ElevatedButton` / `TextButton` / `OutlinedButton`
  - Use `FCard` instead of `Card`
  - Use `FTextField` instead of `TextField` / `TextFormField`
  - Use `FScaffold` instead of `Scaffold`
  - Use `FHeader` instead of `AppBar`
  - Use the equivalent `F*` widget for dialogs, tabs, switches,
    checkboxes, progress indicators, etc.
- Import `package:forui/forui.dart`.
- Wrap the app in `FTheme` and read colors, typography, and styles
  from `context.theme` (e.g. `context.theme.colors`,
  `context.theme.typography`). Do NOT use `Colors.*`, `Theme.of(context)`,
  or hardcoded `TextStyle` values.
- Only fall back to a Material/Cupertino widget if ForUI has no
  equivalent. When that happens, tell the user and explain why.
- Low-level layout widgets (`Row`, `Column`, `Padding`, `SizedBox`,
  `Expanded`, `Stack`, etc.) are fine to use.
- Before using a ForUI widget, check the ForUI docs for its current
  API, and do not guess parameter names.
