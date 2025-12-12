# Cursor Guidelines

These guidelines capture the expectations from `rules.md` in a format optimized
for Cursor assistants. Follow them throughout the demo_shore_bird project.

## Interaction & Persona

- Assume the user understands programming basics but may be new to Dart.
- Always greet responses with `Hi Biv`.
- Default to Dart or Swift if the user does not specify a language.
- Ask for clarification when functionality or target platform is ambiguous.
- Explain Dart-specific topics (null safety, async, streams) when generating
  code.

## Tooling & Workflow

- Prefer absolute paths for tool calls.
- Use `dart_format` for formatting, `dart_fix` for automated fixes, and
  `analyze_files` for lint checks.
- When adding dependencies, use `flutter pub add <package>` (or `pub` tool if
  available); use the appropriate `dev:` or `override:` prefixes as needed.
- Run `dart run build_runner build --delete-conflicting-outputs` after editing
  generated-code inputs.
- Run `flutter test` (or `run_tests` tool) for automated tests.

## Architecture Principles

- Follow MVVM with Clean Architecture separation:
  - **Model**: pure data entities.
  - **ViewModel**: business logic and data transformation only; no UI refs.
  - **View**: UI rendering and interaction only.
- Apply SOLID principles and favor composition over inheritance.
- Use protocol/interface-first dependency injection; inject abstractions, not
  concretes.
- Keep widgets immutable; compose smaller widgets for complex UIs.

## Dependency Injection & Async

- Use constructor injection everywhere possible.
- Provide protocol interfaces for services; only use singletons for truly global
  concerns (e.g., `ConfigurationManager.shared`, `InfinityAnalytics.shared`).
- Use PromiseKit for async Swift code; use Futures/Streams/async-await
  appropriately in Dart.
- Prevent retain cycles with `weak` references in closures.

## Project & File Organization

- Place files under 200 lines when practical; split large files logically.
- Organize code by feature with clear folder structures.
- Separate presentation, domain, data, and core layers.
- Keep mock/test data outside production sources.
- Avoid redundant code; prefer clean, maintainable implementations.

## Naming & Style

- Use descriptive names; no abbreviations or magic numbers.
- Prefer `let` over `var` (Swift) and immutable patterns in Dart.
- Follow casing conventions: PascalCase types, camelCase members, snake_case
  files.
- Limit Dart line length to 80 characters.
- Use concise, declarative, and functional patterns.

## Networking & Data

- Use PromiseKit + `NetworkManager` in Swift; for Flutter use Future/Stream
  abstractions.
- Implement request retries, background sessions, and proper caching.
- Use `json_serializable` with `FieldRename.snake` for JSON.
- Abstract data sources behind repositories/services.

## Error Handling & Logging

- Avoid force unwrapping (`!`). Use guard/optional handling instead.
- Use `InfinityError` for app-specific Swift errors.
- Handle errors with `Result`, `throws`, or PromiseKit `.catch`.
- Use `logging` package (Dart) or `developer.log` for structured logs.
- Log errors through `IssuesLogger.shared` where applicable.

## Configuration & Environment

- Centralize config in `Configuration.swift`; use feature toggles via
  `ConfigurationManager.shared`.
- Support multiple environments (QA, Production) and build configs (Debug,
  Release).
- Manage auth via `InfinityCredentialsManager`, including token refresh and MFA.

## UI / UX / Theming

- Implement state via `@Published`, `ValueNotifier`, `ChangeNotifier`,
  `Streams`, or MVVM ViewModels as appropriate.
- Use `Navigator` or `go_router` (preferred) for routing; configure auth
  redirects.
- Build responsive layouts with `LayoutBuilder`, `MediaQuery`, `Expanded`,
  `Flexible`, `Wrap`, `Stack`, and `OverlayPortal` patterns.
- Apply premium visual style: textured backgrounds, layered shadows, glowing
  interactive elements, iconography, and clear typography hierarchy.
- Centralize theming with `ThemeData`, `ColorScheme.fromSeed`, component themes,
  light/dark modes, and custom `ThemeExtension`s for design tokens.
- Use `google_fonts` for custom fonts; define a typographic scale.

## Assets & Media

- Declare assets in `pubspec.yaml`.
- Use `Image.asset` for local images, `Image.network` for remote images (with
  `loadingBuilder` and `errorBuilder`), and `cached_network_image` when caching.
- Provide placeholders when real assets are unavailable.

## Performance & Resources

- Use lazy loading, caching, and request batching where possible.
- Offload expensive work with isolates (`compute`) or background threads.
- Cancel network requests when views disappear and clean up resources in
  `deinit`.

## Security & Privacy

- Store sensitive data in the Keychain.
- Enforce SSL pinning for payments.
- Validate user inputs rigorously.

## Documentation & Comments

- Document all public APIs with `///` doc comments; start with a concise summary
  sentence followed by a blank line.
- Explain _why_, not _what_; keep comments consistent and meaningful.
- Provide library-level and code-sample documentation where helpful.

## Testing Guidance

- Use Quick/Nimble for Swift tests; use `package:test`, `flutter_test`, and
  `integration_test` for Dart/Flutter.
- Favor mocks/fakes via protocols; prefix with `Mock`.
- Follow Arrange–Act–Assert (or Given–When–Then).
- Aim for high coverage across unit, widget, and integration layers.
- Use `provider` only if explicitly requested for DI/state sharing; otherwise
  rely on manual injection.

## Accessibility & Design Quality

- Meet WCAG 2.1 contrast ratios (4.5:1 normal text, 3:1 large text).
- Support dynamic text scaling and provide semantics labels.
- Test with TalkBack/VoiceOver regularly.

## Interaction Rules Recap

- Always greet with `Hi Biv`.
- Summarize completed and pending tasks at the end of each response.
- Show only changed code in explanations; rely on file references instead of
  duplicating unmodified content.
- Default to ASCII output unless non-ASCII already present and necessary.
