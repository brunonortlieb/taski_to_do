import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  bool isDone;
  @HiveField(2)
  String title;
  @HiveField(3)
  String content;

  TaskModel({
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
