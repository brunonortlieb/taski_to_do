import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/core/constants/hive_boxes.dart';
import 'package:taski_to_do/data/models/task_model.dart';

import '../task_datasource.dart';

class TaskLocalDatasourceImpl extends TaskDatasource {
  final HiveInterface _hive;

  TaskLocalDatasourceImpl(this._hive) {
    if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) Hive.registerAdapter(TaskModelAdapter());
  }

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    final box = await _hive.openBox<TaskModel>(HiveBoxes.task);
    await box.put(task.id, task);
    return task;
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final box = await _hive.openBox<TaskModel>(HiveBoxes.task);
    if (!box.containsKey(task.id)) {
      throw Exception('Task not found');
    }
    await box.put(task.id, task);
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final box = await _hive.openBox<TaskModel>(HiveBoxes.task);
    await box.delete(id);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final box = await _hive.openBox<TaskModel>(HiveBoxes.task);
    return box.values.toList();
  }

  @override
  Future<void> deleteAllTasks(List<String> ids) async {
    final box = await _hive.openBox<TaskModel>(HiveBoxes.task);
    await box.deleteAll(ids);
  }
}
