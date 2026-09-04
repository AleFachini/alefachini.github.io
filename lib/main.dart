import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

/// Root application widget.
///
/// Uses [MaterialApp.router] with GoRouter for navigation
/// and watches the [activeThemeProvider] for theme switching.
class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeKey = ref.watch(activeThemeProvider);
    final themeData =
        AppTheme.themes[themeKey] ?? AppTheme.themes[AppTheme.defaultThemeKey]!;

    return MaterialApp.router(
      title: 'Ale Fachini — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: appRouter,
    );
  }
}
