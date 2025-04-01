import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';
import 'package:taski_to_do/presentation/tasks/pages/done_page.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

import '../../../../testing/entities/task_entity_testing.dart';
import '../../../../testing/mocks.dart';

void main() {
  late MockHomeStore mockStore;

  setUp(() {
    mockStore = MockHomeStore();

    injector.replaceInstance<HomeStore>(mockStore);
  });

  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DonePage()));
  }

  group('DonePage', () {
    testWidgets('should display an empty state when doneList is empty', (WidgetTester tester) async {
      when(() => mockStore.doneList).thenReturn([]);

      await loadScreen(tester);

      expect(find.byType(EmptyListWidget), findsOneWidget);
      expect(find.text('Completed Tasks'), findsOneWidget);
      expect(find.text('Delete all'), findsNothing);
    });

    testWidgets('should display tasks and delete button when doneList is not empty', (WidgetTester tester) async {
      when(() => mockStore.doneList).thenReturn([kTaskEntity]);

      await loadScreen(tester);

      expect(find.byType(TaskWidget), findsOneWidget);
      expect(find.text('Completed Tasks'), findsOneWidget);
      expect(find.text('Delete all'), findsOneWidget);
    });

    testWidgets('should call onDeleteDoneTasks when delete button is pressed', (WidgetTester tester) async {
      when(() => mockStore.doneList).thenReturn([kTaskEntity]);
      when(() => mockStore.onDeleteDoneTasks()).thenAnswer((_) async => const Success(unit));

      await loadScreen(tester);

      await tester.tap(find.text('Delete all'));
      await tester.pump();

      verify(() => mockStore.onDeleteDoneTasks()).called(1);
    });
  });
}
