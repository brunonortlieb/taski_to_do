import 'package:go_router/go_router.dart';
import 'package:taski_to_do/presentation/tasks/pages/home_page.dart';

import 'app_routes.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePage(),
    ),
  ],
);
