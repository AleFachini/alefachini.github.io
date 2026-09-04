import 'package:go_router/go_router.dart';

import '../presentation/home/home_page.dart';

/// Application router configuration.
///
/// Single-page app with one route. Future-proof for sub-routes
/// like `/project/:id` if needed.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
