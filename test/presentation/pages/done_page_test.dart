import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/pages/done_page.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late MockCallback mockDeleteAllTasks;

  setUp(() {
    mockDeleteAllTasks = MockCallback();
  });

  Future<void> loadScreen(WidgetTester tester, List<TaskEntity> tasks) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DonePage(
          doneTasks: tasks,
          onUpdateTask: (_) {},
          onDeleteTask: (_) {},
          onDeleteAllTasks: mockDeleteAllTasks.call,
        ),
      ),
    ));
  }

  group('DonePage', () {
    testWidgets('should show list of done tasks and delete all button',
        (tester) async {
      final tasks = [kTaskEntity, kTaskEntity];
      await loadScreen(tester, tasks);

      expect(find.byType(TaskWidget), findsNWidgets(tasks.length));
      expect(find.text('Delete all'), findsOneWidget);
    });

    testWidgets('should show title and empty state if no done tasks',
        (tester) async {
      await loadScreen(tester, []);

      expect(find.byType(EmptyListWidget), findsOneWidget);
      expect(find.text('Delete all'), findsNothing);
    });

    testWidgets('should call onDeleteAllTasks when delete all is tapped',
        (tester) async {
      await loadScreen(tester, [kTaskEntity]);

      await tester.tap(find.text('Delete all'));
      await tester.pump();

      verify(() => mockDeleteAllTasks.call(any())).called(1);
    });
  });
}
