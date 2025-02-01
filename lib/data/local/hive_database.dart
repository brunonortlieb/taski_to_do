import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/data/local/hive_boxes.dart';
import 'package:taski_to_do/data/local/models/task_model.dart';

class HiveDatabase {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>(HiveBoxes.task);
  }
}
