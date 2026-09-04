---
name: portfolio-conventions
description: >-
  Architecture rules and coding conventions for the Ale Fachini portfolio Flutter Web app.
---

# Portfolio Web App — Architecture & Conventions

This document defines the conventions that ALL agents must follow when working on this project.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter Web |
| State Management | Riverpod (`@riverpod` annotations, code generation) |
| Routing | GoRouter (declarative, named routes) |
| YouTube | `youtube_player_iframe` (Web-compatible) |
| PDF Rendering | PDF.js via sandboxed iframe (web-only, conditional imports) |
| External Links | `url_launcher` |
| Typography | Google Fonts (Inter) |
| Icons | Font Awesome Flutter |
| Deployment | GitHub Pages via GitHub Actions |

---

## Folder Structure

```
lib/
├── main.dart                       # Entry point, ProviderScope, MaterialApp.router
├── app/
│   ├── app.dart                    # Root App widget (if separated from main)
│   └── theme/
│       ├── app_theme.dart          # ThemeData factory + theme registry
│       ├── app_colors.dart         # AppColorPalette class + palette instances
│       └── themes/                 # Additional theme palettes (future)
├── router/
│   └── app_router.dart             # GoRouter configuration
├── data/
│   ├── portfolio_data.dart         # Static content data (projects, certs, profile)
│   └── models/
│       ├── project_model.dart      # Data class for projects
│       └── certificate_model.dart  # Data class for certificates
├── providers/
│   ├── navigation_provider.dart    # Active section tracking
│   ├── side_panel_provider.dart    # Side panel visibility
│   └── theme_provider.dart         # Active theme selection
├── presentation/
│   ├── home/
│   │   └── home_page.dart          # Main scrollable page
│   ├── widgets/                    # Section & component widgets
│   └── shared/                     # Shared utilities & effects
assets/
├── images/profile/                 # Profile photo(s)
├── images/certificates/            # Certificate images (PNG/JPG)
├── pdfs/certificates/              # Certificate PDFs
web/
├── pdfjs/                          # PDF.js library (future: Phase 3)
└── index.html
```

---

## Rules

### State Management
- **ALWAYS** use Riverpod with `@riverpod` annotations (code generation).
- **NEVER** use raw `setState` for state shared across widgets. Use `setState` only for truly local widget state (e.g., hover effects).
- Use `ref.watch` in `build()` methods. Use `ref.read` only inside callbacks/event handlers.
- Extend `ConsumerWidget` or `ConsumerStatefulWidget`, NOT `StatelessWidget`/`StatefulWidget` when the widget needs provider access.

### Routing
- Use GoRouter with declarative navigation (`context.go()`, `context.goNamed()`).
- **NEVER** use imperative `Navigator.push()` calls.
- All routes must have unique `name` values.
- Check `context.mounted` before navigating after async operations.

### Theming
- **NEVER** hardcode colors. Always use `Theme.of(context)` or the `AppColorPalette`.
- To add a new theme: create a new `AppColorPalette` instance → register in `AppTheme.themes`.
- Use `Theme.of(context).textTheme` for all text styles.

### YouTube Videos
- Use `youtube_player_iframe` (not `youtube_player_flutter`) — it's Web-compatible.
- **ALWAYS** dispose `YoutubePlayerController` in the widget's `dispose()` method.
- Videos are embedded inside project cards/detail views, NOT in a standalone section.
- Video IDs are stored in `ProjectModel.youtubeVideoId`.

### PDF Certificates
- Image certificates: render inline, tap to expand fullscreen.
- PDF certificates: render inline via PDF.js iframe (sandboxed).
- PDF.js iframe must use `sandbox="allow-scripts allow-same-origin"`.
- Use conditional imports for web-only code (`dart:html`, `package:web`).

### Content Updates
- ALL portfolio content is defined in `lib/data/portfolio_data.dart`.
- To add a project: add a `ProjectModel` to the `projects` list.
- To add a certificate: place the file in `assets/`, add a `CertificateModel` to `certificates`.
- Profile info: edit `ProfileData` constants.

### Web-Specific
- Use conditional imports for any `dart:html` or `package:web` usage.
- The app deploys to the root of `alefachini.github.io`, so `<base href="/">` is correct.
- GitHub Actions handles the build & deploy automatically on push to `main`.

---

## Deployment
- Push to `main` → GitHub Actions builds (`flutter build web`) → deploys to GitHub Pages.
- Custom domain: `portfolio.bullapps.ar` (CNAME configured in GitHub Pages settings).
