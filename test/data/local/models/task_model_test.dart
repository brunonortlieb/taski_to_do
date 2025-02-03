import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/data/local/models/task_model.dart';

import '../../../fixtures/entities/task_entity_fixture.dart';
import '../../../fixtures/models/task_model_fixture.dart';

void main() {
  group('TaskModel', () {
    final taskEntity = TaskEntityFixture.createDefault();
    final taskModel = TaskModelFixture.createDefault();

    test('fromEntity - should convert TaskEntity to TaskModel correctly', () {
      final result = TaskModel.fromEntity(taskEntity);

      expect(result.id, taskEntity.id);
      expect(result.isDone, taskEntity.isDone);
      expect(result.title, taskEntity.title);
      expect(result.content, taskEntity.content);
    });

    test('toEntity - should convert TaskModel to TaskEntity correctly', () {
      final result = taskModel.toEntity();

      expect(result.id, taskModel.id);
      expect(result.isDone, taskModel.isDone);
      expect(result.title, taskModel.title);
      expect(result.content, taskModel.content);
    });

    test('toEntity and fromEntity - should be inverse', () {
      final convertedEntity = taskModel.toEntity();
      final convertedModel = TaskModel.fromEntity(convertedEntity);

      expect(convertedModel.id, taskModel.id);
      expect(convertedModel.isDone, taskModel.isDone);
      expect(convertedModel.title, taskModel.title);
      expect(convertedModel.content, taskModel.content);
    });
  });
}
