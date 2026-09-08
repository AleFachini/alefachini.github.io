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
    name: 'OrderFast',
    description:
        'Full-stack food-ordering and self-service management platform, including a dashboard, mobile app, and embedded software for self-service totems.',
    technologies: ['React', 'Supabase', 'PostgreSQL', 'Flutter', 'AI-Native Tools'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'ITTI',
    description:
        'Enterprise Flutter applications including Ueno Bank and the ITTI Design System. Spearheaded architecture design, CI/CD pipelines, and AI-integrated workflows.',
    technologies: ['Flutter', 'CI/CD', 'Cursor', 'Google Antigravity'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Código del Sur',
    description:
        'Delivered critical, high-quality features for client applications under aggressive timelines.',
    technologies: ['Flutter', 'BLoC', 'Deep Linking'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Fudo - Deli',
    description:
        'Engineered mobile (Android & iOS) and SmartPOS restaurant applications.',
    technologies: ['Flutter'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Svitla Systems - Video Module',
    description:
        'Web-first application featuring multiple HLS (m3u8) video players with a multithreaded design for improved video performance.',
    technologies: ['Flutter', 'HLS Video Streaming', 'WebRTC'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Independent / Freelance Projects',
    description:
        'Dynamic horse-racing language-learning game and interactive trivia. Built a Windows desktop application for creating customizable presentation software (like PowerPoint) with video calling.',
    technologies: ['Flutter Flame Engine', 'WebRTC', 'Firebase', 'Windows Desktop'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'CloudX',
    description:
        'Large-scale migration of a major fintech application from native iOS/Android to Flutter, implementing MVC architecture and hybrid navigation.',
    technologies: ['Flutter', 'MVC', 'Provider', 'Android', 'Kotlin', 'iOS', 'Swift'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Xseed',
    description:
        'Native SDK for Augmented Reality (AR) floor-plan generation exposed to Flutter via method channels, and a comprehensive data-collection app.',
    technologies: ['Kotlin', 'Swift', 'Flutter', 'AR', 'CI/CD'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'SimTlix Intive',
    description:
        'Digital wallet within a primary banking application with secure API integrations and deep-linked transactions.',
    technologies: ['Flutter', 'Provider', 'GetX', 'Java', 'Spring Boot', 'MySQL'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Baufest',
    description:
        'Data-survey application for mobile and tablet with offline-first capabilities and automatic backend synchronization.',
    technologies: ['Java', 'Spring Boot', 'SQL'],
    youtubeVideoId: null,
    storeUrl: null,
    websiteUrl: null,
  ),
  ProjectModel(
    name: 'Feas Electrónica',
    description:
        'Developed and optimized Real-Time Operating Systems (RTOS) and embedded software solutions.',
    technologies: ['C/C++', 'RTOS'],
    youtubeVideoId: null,
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
