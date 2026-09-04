/// Data model for a production app / project in the portfolio.
class ProjectModel {
  /// Display name of the project.
  final String name;

  /// Brief description of what the project does.
  final String description;

  /// Optional path to app icon asset image.
  final String? iconAssetPath;

  /// Optional URL to the app store listing (Play Store, App Store, etc.).
  final String? storeUrl;

  /// Optional URL to the project website.
  final String? websiteUrl;

  /// List of technology tags (e.g., 'Flutter', 'Firebase', 'Node.js').
  final List<String> technologies;

  /// Optional YouTube video ID for an embedded demo video.
  /// Must be the 11-character video ID, not the full URL.
  final String? youtubeVideoId;

  const ProjectModel({
    required this.name,
    required this.description,
    this.iconAssetPath,
    this.storeUrl,
    this.websiteUrl,
    this.technologies = const [],
    this.youtubeVideoId,
  });
}
