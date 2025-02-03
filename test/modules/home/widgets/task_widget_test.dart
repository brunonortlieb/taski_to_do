import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';
import 'package:taski_to_do/modules/home/widgets/task_widget.dart';

import '../../../fixtures/entities/task_entity_fixture.dart';

class MockTaskEntity extends Mock implements TaskEntity {}

void main() {
  group('TaskWidget', () {
    final mockTask = TaskEntityFixture.createDefaultMock();
    onChanged() {}
    onDelete() {}

    testWidgets('TaskWidget displays task title and content when expanded', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskWidget(
              mockTask,
              onChanged: (task) => onChanged(),
              onDelete: (task) => onDelete(),
            ),
          ),
        ),
      );

      expect(find.text('title'), findsOneWidget);

      expect(find.text('content'), findsNothing);

      await tester.tap(find.byKey(const Key('more')));
      await tester.pump();

      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('TaskWidget calls onChanged when checkbox is toggled', (WidgetTester tester) async {
      bool isChanged = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskWidget(
              mockTask,
              onChanged: (task) => isChanged = true,
              onDelete: (task) => onDelete(),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('isDnoe')));
      await tester.pump();

      expect(isChanged, isTrue);
    });

    testWidgets('TaskWidget calls onDelete when delete button is pressed', (WidgetTester tester) async {
      bool isDeleted = false;

      when(() => mockTask.isDone).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskWidget(
              mockTask,
              onChanged: (task) => onChanged(),
              onDelete: (task) => isDeleted = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('delete')));
      await tester.pump();

      expect(isDeleted, isTrue);
    });

    testWidgets('TaskWidget shows delete button only when task is done', (WidgetTester tester) async {
      when(() => mockTask.isDone).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskWidget(
              mockTask,
              onChanged: (task) => onChanged(),
              onDelete: (task) => onDelete(),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('delete')), findsOneWidget);

      when(() => mockTask.isDone).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskWidget(
              mockTask,
              onChanged: (task) => onChanged(),
              onDelete: (task) => onDelete(),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('delete')), findsNothing);
    });
  });
}
