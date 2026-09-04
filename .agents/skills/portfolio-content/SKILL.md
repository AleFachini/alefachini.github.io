---
name: portfolio-content
description: >-
  How to add projects, videos, certificates, and update profile info in the portfolio web app.
---

# Portfolio Content Management Skill

Step-by-step guide for adding and updating content in the portfolio.

---

## When to Activate

### ✅ Activate on
- Adding a new project to the portfolio.
- Adding a YouTube video to a project.
- Adding a new certificate (image or PDF).
- Updating profile information (name, role, tagline, social links).
- Adding a new theme to the app.

### ❌ Do NOT activate on
- Changing the app architecture or folder structure (see `portfolio-conventions` rule).
- Modifying the build/deploy pipeline.

---

## Workflow

### Adding a New Project

1. Open `lib/data/portfolio_data.dart`.
2. Add a new `ProjectModel` entry to the `projects` list:
   ```dart
   const ProjectModel(
     name: 'My App',
     description: 'Description of the app.',
     technologies: ['Flutter', 'Firebase'],
     youtubeVideoId: 'dQw4w9WgXcQ', // Optional: 11-char YouTube ID
     storeUrl: 'https://play.google.com/store/apps/details?id=com.example',
     iconAssetPath: 'assets/images/my_app_icon.png', // Optional
   ),
   ```
3. If providing an icon, place the image file in `assets/images/` and ensure the directory is registered in `pubspec.yaml`.
4. If providing a YouTube video ID, the video will be embedded in the project detail view. The video can be unlisted — only the ID is needed.

### Adding a Certificate (Image)

1. Place the certificate image (PNG/JPG) in `assets/images/certificates/`.
2. Open `lib/data/portfolio_data.dart`.
3. Add a `CertificateModel` entry:
   ```dart
   const CertificateModel(
     title: 'Flutter Advanced',
     issuer: 'Google',
     date: 'March 2024',
     assetPath: 'assets/images/certificates/flutter_advanced.png',
     type: CertificateType.image,
   ),
   ```

### Adding a Certificate (PDF)

1. Place the PDF file in `assets/pdfs/certificates/`.
2. Open `lib/data/portfolio_data.dart`.
3. Add a `CertificateModel` entry with `CertificateType.pdf`:
   ```dart
   const CertificateModel(
     title: 'AWS Solutions Architect',
     issuer: 'Amazon',
     date: 'June 2024',
     assetPath: 'assets/pdfs/certificates/aws_sa.pdf',
     type: CertificateType.pdf,
   ),
   ```

### Updating Profile Info

1. Open `lib/data/portfolio_data.dart`.
2. Edit the `ProfileData` class constants:
   ```dart
   static const String name = 'Ale Fachini';
   static const String role = 'Senior Flutter Developer';
   static const String tagline = 'Your new tagline here.';
   static const String githubUrl = 'https://github.com/AleFachini';
   static const String linkedInUrl = 'https://linkedin.com/in/alefachini';
   static const String email = 'ale@example.com';
   ```
3. To update the profile photo, replace the image at `assets/images/profile/profile.png`.

### Adding a New Theme

1. Create a new `AppColorPalette` instance (in `lib/app/theme/app_colors.dart` or a new file under `lib/app/theme/themes/`).
2. Register it in `AppTheme.themes` in `lib/app/theme/app_theme.dart`:
   ```dart
   static final Map<String, ThemeData> themes = {
     'darkCyber': buildTheme(darkCyberPalette),
     'myNewTheme': buildTheme(myNewPalette),  // Add here
   };
   ```
3. To set it as default, change `AppTheme.defaultThemeKey`.

---

## Constraints

- **Single source of truth**: ALL content goes in `lib/data/portfolio_data.dart`.
- **No external APIs**: Content is static Dart data — no network calls.
- **Asset registration**: Any new asset directory must be added to `pubspec.yaml` under `flutter > assets`.
- **YouTube IDs only**: Store the 11-character video ID, NOT the full URL.
