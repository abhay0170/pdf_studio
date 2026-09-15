# PDF Studio Architecture

## Where to look first

- `lib/main.dart` starts the application.
- `lib/app/` contains application-wide setup: theme, routing, startup, and the tab shell (`app/shell/main_shell.dart`) that hosts the bottom navigation bar.
- `lib/core/` contains foundational code with no screens of its own — it talks to the device's storage and the PDF engine, and defines *where documents come from* so a cloud backend can be added later without touching any feature.
- `lib/features/` contains user-facing features. Each feature keeps its screen and feature-specific code together.
- `lib/shared/` contains reusable widgets and helpers used by more than one feature. Empty until two features actually need the same thing — nothing goes here "just in case".
- `docs/` explains the project structure and feature responsibilities.

## The pattern every feature follows

Every folder under `lib/features/` is built from the same subfolders, always named the same way:

- `screens/` — the screen itself, what you tap into and look at.
- `widgets/` — reusable visual pieces that screen is built from.
- `models/` — the shape of that feature's data.
- `providers/` — the logic and state behind the screen (Riverpod).
- `services/` — only when a feature talks to files or the PDF engine directly.

Learn this once and every feature folder reads the same way, whether or not you can read code.

Keep feature files named after what they do:

- `documents_screen.dart` for a screen
- `document_tile.dart` for a reusable part of that feature
- `document_repository.dart` for file or storage work
- `document_model.dart` for document data

Avoid vague files such as `utils.dart`, `common.dart`, or `misc.dart`.

## Current structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                 root widget
│   ├── theme/
│   │   ├── app_theme.dart       light & dark ThemeData
│   │   └── app_colors.dart      design tokens (badge tints, gradients, nav states) via context.appColors
│   ├── routing/app_router.dart  every route, listed once
│   ├── shell/main_shell.dart    bottom nav bar + the 4 tabs (Home, Documents, Tools, Profile)
│   └── startup/app_bootstrap.dart
├── core/
│   ├── pdf_engine/              empty — filled in once a PDF package is chosen
│   ├── storage/                 empty — filled in once storage is implemented
│   └── data/repositories/
│       ├── document_repository.dart        the contract
│       └── document_repository_local.dart  today's local-only implementation
├── features/
│   ├── home/         Phase 1 — dashboard tab: quick actions + recent documents (built)
│   ├── documents/    Phase 1 — the full library tab (built)
│   ├── viewer/       Phase 1 — reading a PDF (placeholder screen only)
│   ├── annotations/  Phase 2 — not started (empty folders)
│   ├── page_editor/  Phase 3 — not started (empty folders)
│   ├── export/       Phase 3 — not started (empty folders)
│   └── settings/     Phase 4 — not started (empty folders). The "Profile" tab becomes this feature.
└── shared/
    └── utils/file_size_formatter.dart   used by documents/ and home/
```

The bottom nav's "Tools" and "Profile" tabs are placeholders (`_ComingSoonTab` in `main_shell.dart`) until Tools has something to link to (annotations/page_editor/export) and Profile graduates into the settings feature.

## Build order

Each phase is finished and working before the next one starts:

1. **Documents + Viewer** — browse/import/rename/delete/search a local library; open and read a PDF.
2. **Annotations** — highlight, underline, draw, notes, signature.
3. **Page editor + Export** — reorder/rotate/delete/insert/merge/split pages; save or share the result.
4. **Settings** — app preferences.

Cloud sync is not part of any phase yet. `DocumentRepository` exists as an interface specifically so it can be added later without rewriting the features that use it.
