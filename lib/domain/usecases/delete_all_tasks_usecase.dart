import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

class DeleteAllTasksUseCase {
  final TaskRepository _repository;

  DeleteAllTasksUseCase(this._repository);

  AsyncResult<Unit> call(List<String> taskIds) async {
    if (taskIds.isEmpty) {
      return const Success(unit);
    }
    return _repository.deleteAllTasks(taskIds);
  }
}
