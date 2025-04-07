import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';
import 'package:taski_to_do/presentation/pages/todo_page.dart';

import '../../../testing/entities/task_entity_testing.dart';

void main() {
  late Function(TaskEntity) mockOnCreateTask;
  late Function(TaskEntity) mockOnUpdateTask;
  late Function(TaskEntity) mockOnDeleteTask;

  setUp(() {
    mockOnCreateTask = (TaskEntity task) {};
    mockOnUpdateTask = (TaskEntity task) {};
    mockOnDeleteTask = (TaskEntity task) {};
  });

  Future<void> loadScreen(WidgetTester tester, List<TaskEntity> tasks) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TodoPage(
          todoTasks: tasks,
          onCreateTask: mockOnCreateTask,
          onUpdateTask: mockOnUpdateTask,
          onDeleteTask: mockOnDeleteTask,
        ),
      ),
    );
  }

  group('TodoPage', () {
    testWidgets('should display welcome message and tasks count', (tester) async {
      final tasks = [kTaskEntity, kTaskEntity];
      await loadScreen(tester, tasks);

      expect(find.byKey(const Key('welcomeMessage')), findsOneWidget);
      expect(find.text('You’ve got ${tasks.length} tasks to do.'), findsOneWidget);
    });

    testWidgets('should display an empty state when todoTasks is empty', (tester) async {
      await loadScreen(tester, []);

      expect(find.byType(EmptyListWidget), findsOneWidget);
      expect(find.text('Create tasks to achieve more.'), findsOneWidget);
    });

    testWidgets('should display tasks when todoTasks is not empty', (tester) async {
      final tasks = [kTaskEntity, kTaskEntity];
      await loadScreen(tester, tasks);

      expect(find.byType(TaskWidget), findsNWidgets(tasks.length));
    });

    testWidgets('should show bottom sheet when create button is pressed', (tester) async {
      await loadScreen(tester, []);

      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      expect(find.byType(CreateTaskWidget), findsOneWidget);
    });
  });
}
