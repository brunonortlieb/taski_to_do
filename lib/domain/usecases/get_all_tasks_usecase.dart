import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository _repository;

  GetAllTasksUseCase(this._repository);

  AsyncResult<List<TaskEntity>> call() {
    return _repository.getAllTasks();
  }
}
