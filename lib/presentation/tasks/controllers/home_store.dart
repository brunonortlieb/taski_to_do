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
  ObservableList<TaskEntity> taskList = ObservableList.of([]);
  @computed
  List<TaskEntity> get searchList => taskList.where((e) => e.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  @computed
  List<TaskEntity> get doneList => taskList.where((e) => e.isDone).toList();
  @computed
  List<TaskEntity> get todoList => taskList.where((e) => !e.isDone).toList();
  @computed
  String get tasksTodo => todoList.isEmpty ? 'Create tasks to achieve more.' : 'You’ve got ${todoList.length} tasks to do.';

  String get username => 'John';

  Future<void> init() async {
    await _repository //
        .getAllTasks()
        .onSuccess(taskList.addAll);
  }

  @action
  void setCurrentIndex(int index) => currentIndex = index;

  @action
  AsyncResult<Unit> onDeleteDoneTasks() async {
    return _repository //
        .deleteAllTasks(doneList)
        .onSuccess((_) => taskList.removeWhere((e) => e.isDone));
  }

  @action
  AsyncResult<TaskEntity> onChangeTask(TaskEntity task) async {
    final result = await _repository.updateTask(task);

    result.onSuccess((updatedTask) {
      final index = taskList.indexWhere((e) => e.id == updatedTask.id);
      taskList[index] = updatedTask;
    });

    return result;
  }

  @action
  AsyncResult<Unit> onDeleteTask(TaskEntity task) async {
    return _repository //
        .deleteTask(task)
        .onSuccess((_) => taskList.removeWhere((e) => e.id == task.id));
  }

  @action
  AsyncResult<TaskEntity> onCreateTask(TaskEntity task) async {
    return _repository //
        .addTask(task)
        .onSuccess(taskList.add);
  }

  @action
  void onSearch(String value) => searchQuery = value;
}
