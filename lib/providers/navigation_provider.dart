import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

/// Sections available in the portfolio page.
enum PortfolioSection {
  hero('About'),
  projects('Projects'),
  certificates('Certificates'),
  contact('Contact');

  const PortfolioSection(this.label);

  /// Display label shown in the side navigation.
  final String label;
}

/// Tracks the currently active (visible) section in the viewport.
///
/// Updated by the [HomePage] scroll listener to reflect which section
/// is currently most visible. The [SideNavigationPanel] watches this
/// to highlight the active nav item.
@riverpod
class ActiveSection extends _$ActiveSection {
  @override
  PortfolioSection build() => PortfolioSection.hero;

  /// Update the active section when scrolling.
  void setSection(PortfolioSection section) {
    state = section;
  }
}
