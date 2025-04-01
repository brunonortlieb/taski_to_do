import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool isDone;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;

  const TaskModel({
    required this.id,
    required this.isDone,
    required this.title,
    required this.content,
  });

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      isDone: entity.isDone,
      title: entity.title,
      content: entity.content,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      isDone: isDone,
      title: title,
      content: content,
    );
  }
}
