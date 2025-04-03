part of 'home_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> allTasks;
  final List<TaskEntity> filteredTasks;

  const TaskLoadedState({required this.allTasks, required this.filteredTasks});

  List<TaskEntity> get todoTasks =>
      allTasks.where((task) => !task.isDone).toList();
  List<TaskEntity> get doneTasks =>
      allTasks.where((task) => task.isDone).toList();

  @override
  List<Object> get props => [allTasks, filteredTasks];
}

class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
