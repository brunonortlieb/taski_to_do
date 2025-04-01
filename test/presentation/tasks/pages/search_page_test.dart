import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';

import 'package:taski_to_do/presentation/tasks/pages/search_page.dart';
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

    when(() => mockStore.searchList).thenReturn([]);
    when(() => mockStore.todoList).thenReturn([]);
    when(() => mockStore.onSearch(any())).thenAnswer((_) {});
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SearchPage())));
  }

  group('SearchPage', () {
    testWidgets('should display an empty state when searchList is empty', (WidgetTester tester) async {
      when(() => mockStore.searchList).thenReturn([]);

      await loadScreen(tester);

      expect(find.byType(EmptyListWidget), findsOneWidget);
      expect(find.text('Search...'), findsOneWidget);
    });

    testWidgets('should display tasks when searchList is not empty', (WidgetTester tester) async {
      when(() => mockStore.searchList).thenReturn([kTaskEntity]);

      await loadScreen(tester);

      expect(find.byType(TaskWidget), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('should call onSearch when text is entered in the search field', (WidgetTester tester) async {
      await loadScreen(tester);

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      verify(() => mockStore.onSearch('test')).called(1);
    });

    testWidgets('should clear the search field when clear button is pressed', (WidgetTester tester) async {
      await loadScreen(tester);

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      await tester.tap(find.byKey(const Key('clearSearchButton')));
      await tester.pump();

      expect(find.text('test'), findsNothing);
      verify(() => mockStore.onSearch('')).called(2);
    });

    testWidgets('should show bottom sheet when create button is pressed', (WidgetTester tester) async {
      when(() => mockStore.todoList).thenReturn([]);

      await loadScreen(tester);

      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      expect(find.byType(CreateTaskWidget), findsOneWidget);
    });
  });
}
