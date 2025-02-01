import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TaskEntity extends Equatable {
  final String id;
  final bool isDone;
  final String title;
  final String content;

  TaskEntity({
    String? id,
    this.isDone = false,
    required this.title,
    required this.content,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, isDone, title, content];

  TaskEntity copyWith({
    String? id,
    bool? isDone,
    String? title,
    String? content,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
