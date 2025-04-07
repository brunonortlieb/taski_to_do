import 'package:mobx/mobx.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/domain/usecases/add_task_usecase.dart';
import 'package:taski_to_do/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:taski_to_do/domain/usecases/delete_task_usecase.dart';
import 'package:taski_to_do/domain/usecases/get_all_tasks_usecase.dart';
import 'package:taski_to_do/domain/usecases/update_task_usecase.dart';

part 'home_store.g.dart';

class HomeStore = HomePageBase with _$HomeStore;

abstract class HomePageBase with Store {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final DeleteAllTasksUseCase _deleteAllTasksUseCase;

  HomePageBase(
    this._getAllTasksUseCase,
    this._createTaskUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
    this._deleteAllTasksUseCase,
  );

  @observable
  bool isLoading = false;
  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';
  @observable
  int currentIndex = 0;

  @observable
  ObservableList<TaskEntity> allTasks = ObservableList.of([]);
  @computed
  List<TaskEntity> get filteredTasks =>
      allTasks.where((e) => e.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  @computed
  List<TaskEntity> get doneTasks => allTasks.where((e) => e.isDone).toList();
  @computed
  List<TaskEntity> get todoTasks => allTasks.where((e) => !e.isDone).toList();

  Future<void> init() async {
    isLoading = true;

    final result = await _getAllTasksUseCase();
    result.fold(
      (tasks) => allTasks = ObservableList.of(tasks),
      (failure) => errorMessage = failure.toString(),
    );

    isLoading = false;
  }

  @action
  void setCurrentIndex(int index) => currentIndex = index;

  @action
  Future<void> deleteAllTasks(List<TaskEntity> tasks) async {
    isLoading = true;

    final ids = tasks.map((e) => e.id).toList();
    final result = await _deleteAllTasksUseCase(ids);
    result.fold(
      (_) => allTasks.removeWhere((e) => ids.contains(e.id)),
      (failure) => errorMessage = failure.toString(),
    );

    isLoading = false;
  }

  @action
  Future<void> updateTask(TaskEntity task) async {
    isLoading = true;

    final result = await _updateTaskUseCase(task);
    result.fold(
      (updatedTask) {
        final index = allTasks.indexWhere((e) => e.id == updatedTask.id);
        allTasks[index] = updatedTask;
      },
      (failure) => errorMessage = failure.toString(),
    );

    isLoading = false;
  }

  @action
  Future<void> deleteTask(TaskEntity task) async {
    isLoading = true;

    final result = await _deleteTaskUseCase(task.id);
    result.fold(
      (_) => allTasks.removeWhere((e) => e.id == task.id),
      (failure) => errorMessage = failure.toString(),
    );

    isLoading = false;
  }

  @action
  Future<void> createTask(TaskEntity task) async {
    isLoading = true;

    final result = await _createTaskUseCase(task);
    result.fold(
      allTasks.add,
      (failure) => errorMessage = failure.toString(),
    );

    isLoading = false;
  }

  @action
  void searchTasks(String value) => searchQuery = value;
}
