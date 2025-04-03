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
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SearchTasksEvent>(_searchTasks);
    on<DeleteAllTaskEvent>(_deleteAllTask);
  }

  Future<void> _loadTasksEvent(LoadTasksEvent event, Emitter<TaskState> emit) async {
    final result = await _repository.getAllTasks();
    result.fold(
      (tasks) => emit(TaskLoadedState(allTasks: tasks, filteredTasks: tasks)),
      (failure) => emit(TaskErrorState(failure.toString())),
    );
  }

  Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.addTask(event.task);
    result.fold((newTask) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.add(newTask);

      emit(TaskLoadedState(allTasks: taskList, filteredTasks: currentState.filteredTasks));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  Future<void> _updateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.updateTask(event.task);
    result.fold((updatedTask) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      final index = taskList.indexWhere((e) => e.id == updatedTask.id);
      taskList[index] = updatedTask;

      emit(TaskLoadedState(allTasks: taskList, filteredTasks: currentState.filteredTasks));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  Future<void> _deleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final result = await _repository.deleteTask(event.task.id);
    result.fold((_) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.removeWhere((e) => e.id == event.task.id);
      final filteredTasks = List<TaskEntity>.from(currentState.filteredTasks);
      filteredTasks.removeWhere((e) => e.id == event.task.id);

      emit(TaskLoadedState(allTasks: taskList, filteredTasks: filteredTasks));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }

  void _searchTasks(SearchTasksEvent event, Emitter<TaskState> emit) {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final filteredTasks = currentState.allTasks.where((e) => e.title.toLowerCase().contains(event.query.toLowerCase())).toList();
    emit(TaskLoadedState(
      allTasks: List.from(currentState.allTasks),
      filteredTasks: List.from(filteredTasks),
    ));
  }

  Future<void> _deleteAllTask(DeleteAllTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! TaskLoadedState) return;
    final currentState = state as TaskLoadedState;

    final ids = event.tasks.map((e) => e.id).toList();
    final result = await _repository.deleteAllTasks(ids);
    result.fold((_) {
      final taskList = List<TaskEntity>.from(currentState.allTasks);
      taskList.removeWhere((e) => ids.contains(e.id));
      final filteredTasks = List<TaskEntity>.from(currentState.filteredTasks);
      filteredTasks.removeWhere((e) => ids.contains(e.id));

      emit(TaskLoadedState(allTasks: taskList, filteredTasks: filteredTasks));
    }, (failure) => emit(TaskErrorState(failure.toString())));
  }
}
