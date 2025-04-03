import 'package:go_router/go_router.dart';
import 'package:taski_to_do/presentation/bloc/pages/home_page_bloc.dart';
import 'package:taski_to_do/presentation/tasks/pages/home_page.dart';

import 'app_routes.dart';

final mobxRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePage(),
    ),
  ],
);

final blocRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePageBloc(),
    ),
  ],
);
