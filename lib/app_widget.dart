import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taski_to_do/core/theme/themes.dart';

class AppWidget extends StatelessWidget {
  final GoRouter router;

  const AppWidget(this.router, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
