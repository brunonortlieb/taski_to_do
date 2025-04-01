import 'package:flutter/material.dart';
import 'package:taski_to_do/core/routes/app_router.dart';
import 'package:taski_to_do/core/theme/themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
