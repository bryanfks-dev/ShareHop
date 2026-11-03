# UI Design Token Rules

- Use ONLY existing theme tokens for colors, spacing, font sizes, radius, shadows, spacing, and font weights
  (e.g. `theme.colors.textPrimary`).
- NEVER use hardcode hex/rgb/hsl values or magic numbers.
- EVERY text element must have an explicit theme text color (headings, paragraphs, labels, buttons,
  links, placeholders, helper text). Never rely on inherited or default colors.
- Use tokens semantically: primary text for main content, secondary/muted for supporting text,
  disabled for inactive text, "foreground" for text on filled backgrounds, error/success for status.
- Pair text tokens with the matching background token to keep contrast readable.
- Before writing UI, read the theme file (e.g. `lib/presentation/theme/`) to see the available tokens.
- If no suitable token exists, do NOT invent a raw value. Propose a new token in the theme file and tell the user.
- ALWAYS initiate `final theme = context.theme;` in the build method of a widget to access theme tokens, to cache the theme and avoid unnecessary rebuilds.
- Use the `final theme` variable to access tokens instead of calling `context.theme` multiple times.
