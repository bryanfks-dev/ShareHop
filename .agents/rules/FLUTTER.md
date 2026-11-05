# Flutter Rule

## Spacing in Row, Column, and Flex

Use the `spacing` parameter instead of `SizedBox` for gaps between children.

Do:

- Set `spacing` on `Row`, `Column`, and `Flex` for uniform gaps between children.
- Use `Wrap`'s `spacing` and `runSpacing` for wrapped layouts.

Don't:

- Insert `SizedBox(height: ...)` or `SizedBox(width: ...)` (const or not) between
  children of a `Row` or `Column`.
- Use `Padding` on individual children just to create gaps between siblings.

Example:

// Bad

```
Column(
  children: [
    Text('Title'),
    const SizedBox(height: 8),
    Text('Subtitle'),
    const SizedBox(height: 8),
    Text('Body'),
  ],
)
```

// Good

```
Column(
  spacing: 8,
  children: [
    Text('Title'),
    Text('Subtitle'),
    Text('Body'),
  ],
)
```

Exceptions:

- If one gap must differ from the others, keep `spacing` for the default and add
  a single extra `SizedBox` only for the odd one out.
- `SizedBox` is still fine for fixed-size boxes, or inside non-Row/Column
  parents (e.g. `SizedBox(width: 100, child: ...)`).

## Screen's SingleChildScrollView

- ALWAYS use `padding` for `SingleChildScrollView` to avoid content being cut off by system UI (e.g. status bar, navigation bar, keyboard).
- ALWAYS use `padding` value for screen's `SingleChildScrollView` that is `.only(bottom: 2 * theme.style.pagePadding.bottom)`
- The value ONLY applies to the screen's `SingleChildScrollView` and not for other `SingleChildScrollView` in the widget.

## Screen's SafeArea

- DO NOT set `bottom: false` in screen's `SafeArea`.

## Event Handling Functions

- ALWAYS create a dedicated function for event handling (e.g. onPressed, onTap, onChanged) instead of using an anonymous function.
- The function name SHOULD follow the pattern of `handleOn<EventName>` (e.g. `handleOnPress`, `handleOnTap`, `handleOnChange`) for specific widget usage.
- The function name SHOULD follow the pattern of `handleOn<Action><EventName>` (e.g. `handleOnPressSubmit`, `handleOnChangeSearch`) for widget that contains multiple same actions.
- Function name for `tap` or `press` event use `handleOnPress` instead of `handleOnClick`, `handleOnTap`.
- DO NOT use past tense for function name (e.g. `handleOnPressed`, `handleOnTapped`, `handleOnChanged`), instead use present tense (e.g. `handleOnPress`, `handleOnTap`, `handleOnChange`).

## Event Handling Callback Function Names

- Callback function name SHOULD follow the pattern of `on<EventName>` (e.g. `onPress`, `onTap`, `onChange`) for specific widget usage.
- Callback function name SHOULD follow the pattern of `on<Action><EventName>` (e.g. `onPressSubmit`, `onChangeSearch`) for widget that contains multiple same actions.
- DO NOT use past tense for function name (e.g. `onPressed`, `onTapped`, `onChanged`), instead use present tense (e.g. `onPress`, `onTap`, `onChange`).

## `Sheets` or `Dialogs`

- ALWAYS use `Sheets` over `Dialogs` for popups.
- ALWAYS use `Sheets` for confirmation, information, and selection popups.
- ALWAYS create a dedicated function for `Sheets` instead of using an anonymous function.
- The function name SHOULD follow the pattern of `show<EventName>Sheet` (e.g. `showConfirmationSheet`, `showInformationSheet`, `showSelectionSheet`) for specific widget usage.
- The function name SHOULD follow the pattern of `show<EventName><Action>Sheet` (e.g. `showConfirmationDeleteSheet`, `showInformationSuccessSheet`, `showSelectionFilterSheet`) for widget that contains multiple same actions.
- DO NOT use past tense for function name (e.g. `showConfirmationDeletedSheet`, `showInformationSuccessedSheet`, `showSelectionFilteredSheet`), instead use present tense (e.g. `showConfirmationDeleteSheet`, `showInformationSuccessSheet`, `showSelectionFilterSheet`).

# Builder Widget

- USE `Builder` widget if there are multiple conditionally rendered widgets in the same widget tree.
