import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../testing/entities/task_entity_testing.dart';

void main() {
  group('TaskEntity', () {
    test('Should generate a unique ID if not provided', () {
      final result = TaskEntity(title: 'title', content: 'content');

      expect(result.id, isNotEmpty);
      expect(Uuid.isValidUUID(fromString: result.id), true);
    });

    test('Should use the provided ID if specified', () {
      final task = TaskEntity(
        id: 'id',
        title: 'title',
        content: 'content',
      );

      expect(task.id, equals('id'));
    });

    test('Should create a copy with updated values using copyWith', () {
      const String newId = '456';
      const bool newIsDone = true;
      const String newTitle = 'newTitle';
      const String newContent = 'newContent';

      final result = kTaskEntity.copyWith(
        id: newId,
        isDone: newIsDone,
        title: newTitle,
        content: newContent,
      );

      expect(result.id, equals(newId));
      expect(result.isDone, equals(newIsDone));
      expect(result.title, equals(newTitle));
      expect(result.content, equals(newContent));
    });

    test('Should create a copy with only some values updated using copyWith',
        () {
      const String newTitle = 'newTitle';

      final result = kTaskEntity.copyWith(title: newTitle);

      expect(result.id, equals(kTaskEntity.id));
      expect(result.isDone, equals(kTaskEntity.isDone));
      expect(result.title, equals(newTitle));
      expect(result.content, equals(kTaskEntity.content));
    });
  });
}
