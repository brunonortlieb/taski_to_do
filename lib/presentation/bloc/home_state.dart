part of 'home_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final String filterQuery;
  final List<TaskEntity> allTasks;
  final List<TaskEntity> todoTasks;
  final List<TaskEntity> doneTasks;
  final List<TaskEntity> filteredTasks;

  const TaskLoadedState({
    required this.allTasks,
    required this.todoTasks,
    required this.doneTasks,
    required this.filteredTasks,
    required this.filterQuery,
  });

  @override
  List<Object> get props => [allTasks, filteredTasks];
}

class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
