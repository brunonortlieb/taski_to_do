import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';
import 'package:taski_to_do/core/failures/failure.dart';
import 'package:taski_to_do/core/utils/typedefs.dart';
import 'package:taski_to_do/data/local/models/task_model.dart';

import '../hive_boxes.dart';

class LocalTaskRepository {
  final Box<TaskModel> _box;

  LocalTaskRepository(this._box);

  factory LocalTaskRepository.init() {
    final box = Hive.box<TaskModel>(HiveBoxes.task);
    return LocalTaskRepository(box);
  }

  ResultFuture<void> putTask(TaskEntity value) async {
    try {
      await _box.put(value.id, TaskModel.fromEntity(value));

      return right(null);
    } on Exception {
      return left(const HiveFailure());
    }
  }

  ResultFuture<List<TaskEntity>> getTasks() async {
    try {
      final list = List<TaskEntity>.from(_box.values.map((e) => e.toEntity()));

      return right(list);
    } on Exception {
      return left(const HiveFailure());
    }
  }

  ResultFuture<void> deleteTask(TaskEntity value) async {
    try {
      await _box.delete(value.id);

      return right(null);
    } on Exception {
      return left(const HiveFailure());
    }
  }

  ResultFuture<void> deleteAllTask(List<TaskEntity> values) async {
    try {
      final idList = values.map((e) => e.id);
      await _box.deleteAll(idList);

      return right(null);
    } on Exception {
      return left(const HiveFailure());
    }
  }
}
