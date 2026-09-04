import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app/theme/app_theme.dart';

part 'theme_provider.g.dart';

/// Manages the active theme selection.
///
/// Holds the current theme key and exposes the corresponding [ThemeData].
/// To add a new theme, register it in [AppTheme.themes] and set the key here.
@Riverpod(keepAlive: true)
class ActiveTheme extends _$ActiveTheme {
  @override
  String build() => AppTheme.defaultThemeKey;

  /// Switch to a different theme by key.
  void setTheme(String themeKey) {
    if (AppTheme.themes.containsKey(themeKey)) {
      state = themeKey;
    }
  }

  /// Returns the [ThemeData] for the currently active theme.
  ThemeData get themeData =>
      AppTheme.themes[state] ?? AppTheme.themes[AppTheme.defaultThemeKey]!;
}
