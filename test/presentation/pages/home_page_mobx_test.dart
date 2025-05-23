import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/mobx/home_store.dart';
import 'package:taski_to_do/presentation/pages/done_page.dart';
import 'package:taski_to_do/presentation/pages/home_page_mobx.dart';
import 'package:taski_to_do/presentation/pages/search_page.dart';
import 'package:taski_to_do/presentation/pages/todo_page.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockHomeStore mockStore;

  setUp(() {
    mockStore = MockHomeStore();

    injector.replaceInstance<HomeStore>(mockStore);

    enableWarnWhenNoObservables = false;

    when(() => mockStore.isLoading).thenReturn(false);
    when(() => mockStore.currentIndex).thenReturn(0);
    when(() => mockStore.todoTasks).thenReturn([]);
    when(() => mockStore.filteredTasks).thenReturn([]);
    when(() => mockStore.doneTasks).thenReturn([]);
    when(() => mockStore.init()).thenAnswer((_) async {});
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePageMobx()));
  }

  testWidgets('should display CircularProgressIndicator when state is TaskLoadingState', (tester) async {
    when(() => mockStore.isLoading).thenReturn(true);

    await loadScreen(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(TodoPage), findsNothing);
    expect(find.byType(SearchPage), findsNothing);
    expect(find.byType(DonePage), findsNothing);
  });

  testWidgets('should display AppBar, BottomNavigationBar, and TodoPage when state is TaskLoadedState', (tester) async {
    await loadScreen(tester);

    expect(find.text('Taski'), findsOneWidget);
    expect(find.text('Jhon'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byKey(const Key('Todo')), findsOneWidget);
    expect(find.byKey(const Key('Create')), findsOneWidget);
    expect(find.byKey(const Key('Search')), findsOneWidget);
    expect(find.byKey(const Key('Done')), findsOneWidget);

    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(TodoPage), findsOneWidget);
  });

  testWidgets('should navigate to SearchPage when Search navigation item is tapped', (tester) async {
    await loadScreen(tester);

    expect(find.byType(TodoPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('Search')));
    verify(() => mockStore.setCurrentIndex(2)).called(1);

    when(() => mockStore.currentIndex).thenReturn(2);
    await tester.pumpWidget(const MaterialApp(home: HomePageMobx()));

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(TodoPage), findsNothing);
  });

  testWidgets('should navigate to DonePage when Done navigation item is tapped', (tester) async {
    await loadScreen(tester);

    expect(find.byType(TodoPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('Done')));
    verify(() => mockStore.setCurrentIndex(3)).called(1);

    when(() => mockStore.currentIndex).thenReturn(3);
    await tester.pumpWidget(const MaterialApp(home: HomePageMobx()));

    expect(find.byType(DonePage), findsOneWidget);
    expect(find.byType(TodoPage), findsNothing);
  });

  testWidgets('should show CreateTaskWidget bottom sheet when Create navigation item is tapped', (tester) async {
    await loadScreen(tester);

    expect(find.byType(TodoPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('Create')));
    await tester.pumpAndSettle();

    expect(find.byType(CreateTaskWidget), findsOneWidget);
    expect(find.byType(TodoPage), findsOneWidget);
  });
}
