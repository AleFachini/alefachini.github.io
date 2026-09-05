import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/navigation_provider.dart';
import '../../providers/side_panel_provider.dart';
import 'radial_menu.dart';

/// Overlay that manages the Radial Menu and its slide-in animation.
///
/// Contains a transparent edge detection zone on the left to show the menu,
/// and sliding out the RadialMenu in the bottom-left corner.
class RadialNavigationOverlay extends ConsumerWidget {
  /// Callback invoked when a section nav item is tapped.
  final void Function(PortfolioSection section) onSectionTap;

  const RadialNavigationOverlay({
    super.key,
    required this.onSectionTap,
  });

  static const double _edgeDetectionWidth = 40;
  static const double _menuSize = 320;

  FaIconData _iconForSection(PortfolioSection section) {
    switch (section) {
      case PortfolioSection.hero:
        return FontAwesomeIcons.user;
      case PortfolioSection.projects:
        return FontAwesomeIcons.laptop;
      case PortfolioSection.certificates:
        return FontAwesomeIcons.certificate;
      case PortfolioSection.contact:
        return FontAwesomeIcons.envelope;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(sidePanelVisibleProvider);
    final activeSection = ref.watch(activeSectionProvider);
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Edge detection zone — invisible hover target on the left.
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: _edgeDetectionWidth,
          child: MouseRegion(
            onEnter: (_) => ref.read(sidePanelVisibleProvider.notifier).show(),
            opaque: false,
            child: const SizedBox.expand(),
          ),
        ),

        // The actual slide-in radial menu.
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          left: isVisible ? 0 : -_menuSize,
          bottom: 0,
          width: _menuSize,
          height: _menuSize,
          child: MouseRegion(
            onExit: (_) => ref.read(sidePanelVisibleProvider.notifier).hide(),
            child: RadialMenu(
              baseColor: theme.colorScheme.surface.withValues(alpha: 0.95),
              activeColor: theme.colorScheme.primary,
              textColor: theme.colorScheme.onSurface,
              iconColor: theme.colorScheme.onSurface,
              originOffset: const Offset(20, 20),
              baseRadius: 100,
              activeRadius: 150,
              gapDegrees: 6,
              cornerRadius: 12,
              startAngleDeg: 10,
              totalSpanDeg: 90,
              items: PortfolioSection.values.map((section) {
                final isActive = section == activeSection;
                return RadialMenuItem(
                  icon: _iconForSection(section),
                  label: section.label,
                  isActive: isActive,
                  onSelected: () {
                    onSectionTap(section);
                    ref.read(sidePanelVisibleProvider.notifier).hide();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
