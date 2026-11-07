# Dart Rule

## Use Dot Shorthands

This project uses Dart 3.10+. Prefer dot shorthands when the context type is
obvious from a typed parameter, variable, or return type.

Do:

- `mainAxisSize: .min`
- `crossAxisAlignment: .start`
- `Alignment alignment = .center;`
- `padding: .all(16)`
- `mainAxisAlignment: .spaceBetween`

Don't:

- `mainAxisSize: MainAxisSize.min`
- `crossAxisAlignment: CrossAxisAlignment.start`
- `Alignment alignment = Alignment.center;`
- `padding: EdgeInsets.all(16)`
- `mainAxisAlignment: MainAxisAlignment.spaceBetween`

- Use shorthand where there's no context type (`var x = .min;` won't compile).
- Use shorthand when it hurts readability, such as in a long argument list
  where the type isn't obvious at a glance.
- Rewrite existing code to shorthand unless asked.

## Named Parameters

- Named parameters only used if the function name is descriptive enough to explain the parameter's purpose. For example, `void setUser(User user)` is descriptive enough to not require a named parameter. However, `void setUser(User user, bool isAdmin)` is not descriptive enough and should use named parameters: `void setUser({required User user, required bool isAdmin})`.
- NEVER use positional parameters for function parameters.
- Use named parameters for model or DTO classes.
- DO NOT use named parameters for mapper classes.
- DO NOT use named parameters for `BuildContext` parameters in funcitons or methods.

# Single Line If Statements

- DO NOT use single line if statements. Always use braces for if statements, even for single line statements.

# Constant Naming

- Use `camelCase` for constant names. Do not use `ALL_CAPS` for constant names.
- Use `k` prefix for constant names. For example, `kMyConstant`.
- Use `const` keyword for constant values. For example, `const kMyConstant = 42;`.
