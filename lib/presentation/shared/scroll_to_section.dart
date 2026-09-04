import 'package:flutter/material.dart';

/// Utility to smooth-scroll to a section by its [GlobalKey].
///
/// Usage:
/// ```dart
/// ScrollToSection.scrollTo(sectionKey, scrollController);
/// ```
class ScrollToSection {
  ScrollToSection._();

  /// Smooth-scrolls the [scrollController] so that the widget
  /// associated with [sectionKey] is visible at the top of the viewport.
  static Future<void> scrollTo(
    GlobalKey sectionKey,
    ScrollController scrollController, {
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    final context = sectionKey.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: duration,
      curve: curve,
      alignment: 0.0,
    );
  }
}
