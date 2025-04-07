import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  AsyncResult<TaskEntity> call(TaskEntity task) {
    return _repository.updateTask(task);
  }
}
