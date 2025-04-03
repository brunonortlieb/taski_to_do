import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';
import 'package:taski_to_do/presentation/tasks/pages/home_page.dart';
import 'package:taski_to_do/presentation/tasks/pages/search_page.dart';
import 'package:taski_to_do/presentation/tasks/pages/todo_page.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';

import '../../../../testing/mocks.dart';

void main() {
  late MockHomeStore mockStore;

  setUp(() {
    mockStore = MockHomeStore();

    injector.replaceInstance<HomeStore>(mockStore);

    enableWarnWhenNoObservables = false;

    when(() => mockStore.currentIndex).thenReturn(0);
    when(() => mockStore.username).thenReturn('John');
    when(() => mockStore.init()).thenAnswer((_) async {});
    when(() => mockStore.tasksTodo).thenReturn('');
    when(() => mockStore.todoTasks).thenReturn([]);
    when(() => mockStore.filteredTasks).thenReturn([]);
    when(() => mockStore.doneTasks).thenReturn([]);
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
  }

  group('HomePage', () {
    testWidgets(
        'should display the AppBar with correct title and user information',
        (WidgetTester tester) async {
      await loadScreen(tester);

      expect(find.text('Taski'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('should display the correct page based on currentIndex',
        (WidgetTester tester) async {
      when(() => mockStore.currentIndex).thenReturn(0);

      await loadScreen(tester);

      expect(find.byType(TodoPage), findsOneWidget);

      when(() => mockStore.currentIndex).thenReturn(2);

      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(SearchPage), findsOneWidget);
    });

    testWidgets(
        'should call setCurrentIndex when tapping on BottomNavigationBar items',
        (WidgetTester tester) async {
      when(() => mockStore.setCurrentIndex(any())).thenAnswer((_) {});

      await loadScreen(tester);

      await tester.tap(find.byKey(const Key('Todo')));
      await tester.pump();

      verify(() => mockStore.setCurrentIndex(0)).called(1);
    });

    testWidgets('should show bottom sheet when tapping on Create button',
        (WidgetTester tester) async {
      await loadScreen(tester);

      await tester.tap(find.byKey(const Key('Create')));
      await tester.pumpAndSettle();

      expect(find.byType(CreateTaskWidget), findsOneWidget);
    });
  });
}
