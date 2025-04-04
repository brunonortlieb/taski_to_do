part of 'home_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskEntity task;
  const CreateTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;
  const UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final TaskEntity task;
  const DeleteTaskEvent(this.task);
}

class SearchTasksEvent extends TaskEvent {
  final String query;
  const SearchTasksEvent(this.query);
}

class DeleteAllTaskEvent extends TaskEvent {
  final List<TaskEntity> tasks;
  const DeleteAllTaskEvent(this.tasks);
}
