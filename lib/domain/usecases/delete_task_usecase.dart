import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  AsyncResult<Unit> call(String taskId) {
    return _repository.deleteTask(taskId);
  }
}
