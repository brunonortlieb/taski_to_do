import 'package:go_router/go_router.dart';
import 'package:taski_to_do/presentation/pages/home_page_bloc.dart';
import 'package:taski_to_do/presentation/pages/home_page_mobx.dart';

import 'app_routes.dart';

final mobxRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePageMobx(),
    ),
  ],
);

final blocRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePageBloc(),
    ),
  ],
);
