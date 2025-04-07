import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/bloc/home_bloc.dart';
import 'package:taski_to_do/presentation/pages/done_page.dart';
import 'package:taski_to_do/presentation/pages/home_page_bloc.dart';
import 'package:taski_to_do/presentation/pages/search_page.dart';
import 'package:taski_to_do/presentation/pages/todo_page.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockHomeBloc mockBloc;
  late MockTaskLoadedState mockTaskLoadedState;

  setUp(() {
    mockBloc = MockHomeBloc();
    mockTaskLoadedState = MockTaskLoadedState();

    injector.replaceInstance<HomeBloc>(mockBloc);

    when(() => mockBloc.state).thenReturn(mockTaskLoadedState);
    when(() => mockTaskLoadedState.todoTasks).thenReturn([]);
    when(() => mockTaskLoadedState.filteredTasks).thenReturn([]);
    when(() => mockTaskLoadedState.doneTasks).thenReturn([]);
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePageBloc()));
  }

  testWidgets('should display CircularProgressIndicator when state is TaskLoadingState', (tester) async {
    when(() => mockBloc.state).thenReturn(TaskLoadingState());

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
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(TodoPage), findsNothing);
  });

  testWidgets('should navigate to DonePage when Done navigation item is tapped', (tester) async {
    await loadScreen(tester);

    expect(find.byType(TodoPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('Done')));
    await tester.pumpAndSettle();

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
