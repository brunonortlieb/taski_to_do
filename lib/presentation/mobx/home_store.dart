import 'package:mobx/mobx.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomePageBase with _$HomeStore;

abstract class HomePageBase with Store {
  final TaskRepository _repository;

  HomePageBase(this._repository);

  @observable
  String searchQuery = '';
  @observable
  int currentIndex = 0;

  @observable
  ObservableList<TaskEntity> allTasks = ObservableList.of([]);
  @computed
  List<TaskEntity> get filteredTasks => allTasks
      .where((e) => e.title.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();
  @computed
  List<TaskEntity> get doneTasks => allTasks.where((e) => e.isDone).toList();
  @computed
  List<TaskEntity> get todoTasks => allTasks.where((e) => !e.isDone).toList();

  Future<void> init() async {
    await _repository //
        .getAllTasks()
        .onSuccess(allTasks.addAll);
  }

  @action
  void setCurrentIndex(int index) => currentIndex = index;

  @action
  AsyncResult<Unit> deleteAllTasks(List<TaskEntity> tasks) async {
    final ids = tasks.map((e) => e.id).toList();

    return _repository //
        .deleteAllTasks(ids)
        .onSuccess((_) => allTasks.removeWhere((e) => ids.contains(e.id)));
  }

  @action
  AsyncResult<TaskEntity> updateTask(TaskEntity task) async {
    final result = await _repository.updateTask(task);

    result.onSuccess((updatedTask) {
      final index = allTasks.indexWhere((e) => e.id == updatedTask.id);
      allTasks[index] = updatedTask;
    });

    return result;
  }

  @action
  AsyncResult<Unit> deleteTask(TaskEntity task) async {
    return _repository //
        .deleteTask(task.id)
        .onSuccess((_) => allTasks.removeWhere((e) => e.id == task.id));
  }

  @action
  AsyncResult<TaskEntity> createTask(TaskEntity task) async {
    return _repository //
        .addTask(task)
        .onSuccess(allTasks.add);
  }

  @action
  void searchTasks(String value) => searchQuery = value;
}
