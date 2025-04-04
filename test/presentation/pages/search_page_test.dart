import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/pages/search_page.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';

import '../../../testing/entities/task_entity_testing.dart';

void main() {
  Future<void> loadScreen(
      WidgetTester tester, List<TaskEntity> filteredTasks) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SearchPage(
          filteredTasks: filteredTasks,
          todoTasks: const [],
          onSearchTasks: (_) {},
          onCreateTask: (_) {},
          onUpdateTask: (_) {},
          onDeleteTask: (_) {},
        ),
      ),
    ));
  }

  group('SearchPage', () {
    testWidgets('should display search field and clear button', (tester) async {
      await loadScreen(tester, []);

      final textfield = find.byType(TextField);
      final clearButton = find.byKey(const Key('clearSearchButton'));

      expect(textfield, findsOneWidget);
      expect(clearButton, findsOneWidget);

      await tester.enterText(textfield, 'text');
      expect(find.text('text'), findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump();

      expect(find.text('text'), findsNothing);
    });

    testWidgets('should display tasks when filteredTasks is not empty',
        (tester) async {
      final tasks = [kTaskEntity, kTaskEntity];
      await loadScreen(tester, tasks);

      expect(find.byType(TaskWidget), findsNWidgets(tasks.length));
    });

    testWidgets('should display an empty state when filteredTasks is empty',
        (tester) async {
      await loadScreen(tester, []);

      expect(find.byType(EmptyListWidget), findsOneWidget);
    });
  });
}
