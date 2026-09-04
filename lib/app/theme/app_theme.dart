import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds a [ThemeData] from an [AppColorPalette].
///
/// This factory approach allows creating multiple themes from different
/// palettes while keeping a consistent structure.
class AppTheme {
  AppTheme._();

  /// Registry of available themes keyed by name.
  static final Map<String, ThemeData> themes = {
    'darkCyber': buildTheme(darkCyberPalette),
  };

  /// Default theme key.
  static const String defaultThemeKey = 'darkCyber';

  /// Builds a complete [ThemeData] from a given palette.
  static ThemeData buildTheme(AppColorPalette palette) {
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: palette.background,
      colorScheme: ColorScheme.dark(
        primary: palette.primary,
        secondary: palette.secondary,
        surface: palette.surface,
        error: const Color(0xFFEF4444),
        onPrimary: palette.background,
        onSecondary: palette.textPrimary,
        onSurface: palette.textPrimary,
        onError: palette.textPrimary,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: palette.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: palette.textSecondary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: palette.textSecondary,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: palette.textMuted,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          color: palette.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: palette.cardBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.divider,
        thickness: 1,
      ),
      iconTheme: IconThemeData(
        color: palette.textSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
