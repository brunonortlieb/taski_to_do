import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';

import '../../fixtures/entities/task_entity_fixture.dart';

void main() {
  group('TaskEntity', () {
    final taskEntity = TaskEntityFixture.createDefault();

    test('props should contain id, isDone, title, and content', () {
      expect(taskEntity.props, [taskEntity.id, taskEntity.isDone, taskEntity.title, taskEntity.content]);
    });

    test('copyWith should update the specified fields', () {
      final updatedEntity = taskEntity.copyWith(
        isDone: true,
        title: 'Updated Task',
        content: 'This is an updated task.',
      );

      expect(updatedEntity.id, taskEntity.id);
      expect(updatedEntity.isDone, true);
      expect(updatedEntity.title, 'Updated Task');
      expect(updatedEntity.content, 'This is an updated task.');
    });

    test('copyWith should not update fields if no values are provided', () {
      final unchangedEntity = taskEntity.copyWith();

      expect(unchangedEntity.id, taskEntity.id);
      expect(unchangedEntity.isDone, taskEntity.isDone);
      expect(unchangedEntity.title, taskEntity.title);
      expect(unchangedEntity.content, taskEntity.content);
    });

    test('should generate a new UUID if no id is provided', () {
      final newEntity = TaskEntity(
        title: 'New Task',
        content: 'This is a new task.',
      );

      expect(newEntity.id, isNotNull);
      expect(newEntity.id, isNotEmpty);
    });
  });
}
