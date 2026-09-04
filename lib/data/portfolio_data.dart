import 'models/project_model.dart';
import 'models/certificate_model.dart';

/// =============================================================
/// PORTFOLIO CONTENT DATA
/// =============================================================
/// Edit this file to add, remove, or update portfolio content.
/// All sections of the portfolio read from these static lists.
/// =============================================================

/// Profile information displayed in the Hero section.
class ProfileData {
  ProfileData._();

  static const String name = 'Ale Fachini';
  static const String role = 'Flutter Developer';
  static const String tagline =
      'Building beautiful, high-performance mobile & web experiences.';
  static const String profileImageAsset = 'assets/images/profile/profile.png';

  /// Social links — set to empty string to hide.
  static const String githubUrl = 'https://github.com/AleFachini';
  static const String linkedInUrl = '';
  static const String email = '';
}

/// Production apps and projects.
///
/// To add a new project:
/// 1. Add a [ProjectModel] entry below.
/// 2. Optionally place an icon in `assets/images/` and reference it.
/// 3. To embed a YouTube video, set [youtubeVideoId] to the 11-char video ID.
const List<ProjectModel> projects = [
  ProjectModel(
    name: 'Example App',
    description:
        'A sample production app showcasing Flutter capabilities. Replace this with your real project.',
    technologies: ['Flutter', 'Firebase', 'Riverpod'],
    youtubeVideoId: null, // e.g., 'dQw4w9WgXcQ'
    storeUrl: null,
    websiteUrl: null,
  ),
];

/// Certificates and credentials.
///
/// To add a new certificate:
/// 1. Place the image in `assets/images/certificates/` or PDF in `assets/pdfs/certificates/`.
/// 2. Add a [CertificateModel] entry below with the correct [CertificateType].
const List<CertificateModel> certificates = [
  CertificateModel(
    title: 'Example Certificate',
    issuer: 'Example Academy',
    date: 'September 2026',
    assetPath: 'assets/images/certificates/example.png',
    type: CertificateType.image,
  ),
];
