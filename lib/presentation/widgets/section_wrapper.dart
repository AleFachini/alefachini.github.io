import 'package:flutter/material.dart';

/// Reusable wrapper that provides consistent styling and a [GlobalKey]
/// anchor for each portfolio section.
///
/// Every section in the portfolio is wrapped with this widget to ensure:
/// - Consistent horizontal padding and max-width constraints.
/// - A [GlobalKey] that the scroll-to-section utility can target.
/// - An optional section title rendered above the content.
class SectionWrapper extends StatelessWidget {
  /// The unique key used for scroll-to targeting.
  final GlobalKey sectionKey;

  /// Optional section title displayed above the content.
  final String? title;

  /// The section content.
  final Widget child;

  /// Minimum height for the section. Defaults to 0 (content-sized).
  final double? minHeight;

  /// Whether to add vertical padding. Defaults to true.
  final bool addVerticalPadding;

  const SectionWrapper({
    super.key,
    required this.sectionKey,
    required this.child,
    this.title,
    this.minHeight,
    this.addVerticalPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: addVerticalPadding ? 80 : 0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 40),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
