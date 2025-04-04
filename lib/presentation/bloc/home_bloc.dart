import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;

  HomeBloc(this._repository) : super(TaskLoadingState()) {
    on<LoadTasksEvent>(_loadTasksEvent);
    on<CreateTaskEvent>(_createTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SearchTasksEvent>(_searchTasks);
    on<DeleteAllTaskEvent>(_deleteAllTask);
  }

  Future<void> _loadTasksEvent(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    final result = await _repository.getAllTasks();
    result.fold(
      (tasks) => emit(TaskLoadedState(
        filterQuery: '',
        allTasks: tasks,
        filteredTasks: tasks,
        doneTasks: tasks.where((task) => task.isDone).toList(),
        todoTasks: tasks.where((task) => !task.isDone).toList(),
      )),
      (failure) => emit(TaskErrorState(failure.toString())),
    );
  }

  Future<void> _createTask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.addTask(event.task);
    result.fold((newTask) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.add(newTask);

      emit(_updateState(currentState, allTasks: taskList));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  Future<void> _updateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.updateTask(event.task);
    result.fold((updatedTask) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      final index = taskList.indexWhere((e) => e.id == updatedTask.id);
      taskList[index] = updatedTask;

      emit(_updateState(currentState, allTasks: taskList));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.deleteTask(event.task.id);
    result.fold((_) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.removeWhere((e) => e.id == event.task.id);

      emit(_updateState(currentState, allTasks: taskList));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  void _searchTasks(SearchTasksEvent event, Emitter<TaskState> emit) {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    emit(_updateState(currentState, filterQuery: event.query));
  }

  Future<void> _deleteAllTask(
      DeleteAllTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final ids = event.tasks.map((e) => e.id).toList();
    final result = await _repository.deleteAllTasks(ids);
    result.fold((_) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.removeWhere((e) => ids.contains(e.id));

      emit(_updateState(currentState, allTasks: taskList));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  TaskLoadedState _updateState(TaskLoadedState state,
      {List<TaskEntity>? allTasks, String? filterQuery}) {
    final todoTasks = allTasks?.where((task) => !task.isDone).toList();
    final doneTasks = allTasks?.where((task) => task.isDone).toList();
    final filteredTasks = (allTasks ?? state.allTasks)
        .where((e) => e.title
            .toLowerCase()
            .contains((filterQuery ?? state.filterQuery).toLowerCase()))
        .toList();

    return TaskLoadedState(
      allTasks: allTasks ?? state.allTasks,
      todoTasks: todoTasks ?? state.todoTasks,
      doneTasks: doneTasks ?? state.doneTasks,
      filteredTasks: filteredTasks,
      filterQuery: filterQuery ?? state.filterQuery,
    );
  }
}
