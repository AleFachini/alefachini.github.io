import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/navigation_provider.dart';
import '../../providers/side_panel_provider.dart';

/// Simple side navigation panel.
///
/// Appears when the user hovers over the left edge of the viewport.
/// Shows section links that smooth-scroll to the target section.
///
/// **Note**: This is a simple functional version. An animated/fancy
/// menu design is planned as a future improvement.
class SideNavigationPanel extends ConsumerWidget {
  /// Callback invoked when a section nav item is tapped.
  final void Function(PortfolioSection section) onSectionTap;

  const SideNavigationPanel({
    super.key,
    required this.onSectionTap,
  });

  static const double _edgeDetectionWidth = 40;
  static const double _panelWidth = 220;

  IconData _iconForSection(PortfolioSection section) {
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

        // The actual slide-in panel.
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          left: isVisible ? 0 : -_panelWidth,
          top: 0,
          bottom: 0,
          width: _panelWidth,
          child: MouseRegion(
            onExit: (_) => ref.read(sidePanelVisibleProvider.notifier).hide(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(4, 0),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    // Nav items
                    ...PortfolioSection.values.map((section) {
                      final isActive = section == activeSection;
                      return _NavItem(
                        icon: _iconForSection(section),
                        label: section.label,
                        isActive: isActive,
                        onTap: () {
                          onSectionTap(section);
                          ref.read(sidePanelVisibleProvider.notifier).hide();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isHighlighted = widget.isActive || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: isHighlighted
                ? primaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: widget.isActive ? primaryColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: isHighlighted ? primaryColor : Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isHighlighted
                            ? primaryColor
                            : Theme.of(context).textTheme.titleMedium?.color,
                        fontWeight:
                            widget.isActive ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
