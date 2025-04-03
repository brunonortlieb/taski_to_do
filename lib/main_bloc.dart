import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/app_widget.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  blocInjection();

  return runApp(AppWidget(blocRouter));
}
