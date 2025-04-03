import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';
import 'package:taski_to_do/presentation/tasks/pages/todo_page.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

import '../../../../testing/entities/task_entity_testing.dart';
import '../../../../testing/mocks.dart';

void main() {
  late MockHomeStore mockStore;

  setUp(() {
    mockStore = MockHomeStore();

    injector.replaceInstance<HomeStore>(mockStore);

    enableWarnWhenNoObservables = false;

    registerFallbackValue(kTaskEntity);

    when(() => mockStore.username).thenReturn('John');
    when(() => mockStore.tasksTodo).thenReturn('tasksTodo');
    when(() => mockStore.todoTasks).thenReturn([kTaskEntity]);
    when(() => mockStore.onCreateTask(any())).thenAnswer((_) async => Success(kTaskEntity));
    when(() => mockStore.onChangeTask(any())).thenAnswer((_) async => Success(kTaskEntity));
    when(() => mockStore.onDeleteTask(any())).thenAnswer((_) async => const Success(unit));
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: TodoPage())));
  }

  group('TodoPage', () {
    testWidgets('should display welcome message and tasks count', (WidgetTester tester) async {
      await loadScreen(tester);

      expect(find.byKey(const Key('welcomeMessage')), findsOneWidget);
      expect(find.text('tasksTodo'), findsOneWidget);
    });

    testWidgets('should display an empty state when todoTasks is empty', (WidgetTester tester) async {
      when(() => mockStore.todoTasks).thenReturn([]);

      await loadScreen(tester);

      expect(find.byType(EmptyListWidget), findsOneWidget);
    });

    testWidgets('should display tasks when todoTasks is not empty', (WidgetTester tester) async {
      await loadScreen(tester);

      expect(find.byType(TaskWidget), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('should show bottom sheet when create button is pressed', (WidgetTester tester) async {
      when(() => mockStore.todoTasks).thenReturn([]);

      await loadScreen(tester);

      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      expect(find.byType(CreateTaskWidget), findsOneWidget);
    });
  });
}
