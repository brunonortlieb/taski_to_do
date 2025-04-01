import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/data/models/task_model.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/models/task_model_testing.dart';

void main() {
  group('TaskModel', () {
    test('Should convert to [TaskEntity] correctly', () {
      final result = kTaskModel.toEntity();

      expect(result.id, equals(kTaskModel.id));
      expect(result.isDone, equals(kTaskModel.isDone));
      expect(result.title, equals(kTaskModel.title));
      expect(result.content, equals(kTaskModel.content));
    });
    test('Should convert from [TaskEntity] correctly', () {
      final result = TaskModel.fromEntity(kTaskEntity);

      expect(result.id, equals(kTaskEntity.id));
      expect(result.isDone, equals(kTaskEntity.isDone));
      expect(result.title, equals(kTaskEntity.title));
      expect(result.content, equals(kTaskEntity.content));
    });
  });
}
