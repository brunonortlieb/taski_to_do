import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';

abstract class TaskRepository {
  AsyncResult<List<TaskEntity>> getAllTasks();
  AsyncResult<TaskEntity> createTask(TaskEntity task);
  AsyncResult<TaskEntity> updateTask(TaskEntity task);
  AsyncResult<Unit> deleteTask(String id);
  AsyncResult<Unit> deleteAllTasks(List<String> ids);
}
