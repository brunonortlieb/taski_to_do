import 'package:taski_to_do/data/models/task_model.dart';

abstract class TaskDatasource {
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<void> deleteAllTasks(List<TaskModel> tasks);
}
