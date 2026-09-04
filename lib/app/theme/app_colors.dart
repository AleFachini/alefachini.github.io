import 'package:flutter/material.dart';

/// Curated color palette for the portfolio.
/// Each theme provides its own [AppColorPalette] implementation.
class AppColorPalette {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color divider;
  final Color cardBackground;
  final Color cardBorder;
  final Gradient heroGradient;
  final Gradient accentGradient;

  const AppColorPalette({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.divider,
    required this.cardBackground,
    required this.cardBorder,
    required this.heroGradient,
    required this.accentGradient,
  });
}

/// Default dark cyberpunk palette.
const darkCyberPalette = AppColorPalette(
  background: Color(0xFF0A0E1A),
  surface: Color(0xFF111827),
  surfaceVariant: Color(0xFF1F2937),
  primary: Color(0xFF00F5D4),
  primaryVariant: Color(0xFF00C4A7),
  secondary: Color(0xFF7B61FF),
  accent: Color(0xFFFF6B9D),
  textPrimary: Color(0xFFF9FAFB),
  textSecondary: Color(0xFFD1D5DB),
  textMuted: Color(0xFF6B7280),
  divider: Color(0xFF374151),
  cardBackground: Color(0x1A00F5D4),
  cardBorder: Color(0x3300F5D4),
  heroGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A0E1A),
      Color(0xFF1A0A2E),
      Color(0xFF0A1628),
    ],
  ),
  accentGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00F5D4),
      Color(0xFF7B61FF),
    ],
  ),
);
