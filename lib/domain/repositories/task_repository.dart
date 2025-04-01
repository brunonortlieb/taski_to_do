import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';

abstract class TaskRepository {
  AsyncResult<List<TaskEntity>> getAllTasks();
  AsyncResult<TaskEntity> addTask(TaskEntity task);
  AsyncResult<TaskEntity> updateTask(TaskEntity task);
  AsyncResult<Unit> deleteTask(TaskEntity task);
  AsyncResult<Unit> deleteAllTasks(List<TaskEntity> tasks);
}
