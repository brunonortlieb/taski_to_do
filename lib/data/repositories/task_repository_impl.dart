import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/data/datasources/task_datasource.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/data/models/task_model.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource datasource;

  TaskRepositoryImpl(this.datasource);

  @override
  AsyncResult<List<TaskEntity>> getAllTasks() async {
    try {
      final tasks = await datasource.getAllTasks();
      return Success(tasks.map((model) => model.toEntity()).toList());
    } catch (e, s) {
      return Failure(CacheException('Failed to get all tasks', s));
    }
  }

  @override
  AsyncResult<TaskEntity> addTask(TaskEntity task) async {
    try {
      await datasource.addTask(TaskModel.fromEntity(task));
      return Success(task);
    } catch (e, s) {
      return Failure(CacheException('Failed to add task', s));
    }
  }

  @override
  AsyncResult<TaskEntity> updateTask(TaskEntity task) async {
    try {
      await datasource.updateTask(TaskModel.fromEntity(task));
      return Success(task);
    } catch (e, s) {
      return Failure(CacheException('Failed to update task', s));
    }
  }

  @override
  AsyncResult<Unit> deleteTask(String id) async {
    try {
      await datasource.deleteTask(id);
      return const Success(unit);
    } catch (e, s) {
      return Failure(CacheException('Failed to delete task', s));
    }
  }

  @override
  AsyncResult<Unit> deleteAllTasks(List<String> ids) async {
    try {
      await datasource.deleteAllTasks(ids);
      return const Success(unit);
    } catch (e, s) {
      return Failure(CacheException('Failed to delete task', s));
    }
  }
}
