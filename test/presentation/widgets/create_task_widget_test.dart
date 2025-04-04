import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';

void main() {
  late Function(TaskEntity) mockOnCreate;

  setUp(() {
    mockOnCreate = (TaskEntity task) {};
  });

  group('CreateTaskWidget', () {
    testWidgets('should display form fields and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CreateTaskWidget(mockOnCreate),
          ),
        ),
      );

      expect(find.text('What’s in your mind?'), findsOneWidget);
      expect(find.text('Add a note...'), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
      expect(find.byType(ImageIcon), findsNWidgets(2));
    });

    testWidgets('should validate form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CreateTaskWidget(mockOnCreate),
          ),
        ),
      );

      await tester.tap(find.text('Create'));
      await tester.pump();
      expect(find.text('What’s in your mind?'), findsOneWidget);
    });

    testWidgets('should call onCreate when form is valid',
        (WidgetTester tester) async {
      TaskEntity? createdTask;
      mockOnCreate = (TaskEntity task) {
        createdTask = task;
      };

      final router = GoRouter(
        initialLocation: '/route',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Text('home'),
            routes: [
              GoRoute(
                path: 'route',
                builder: (_, __) => Scaffold(
                  body: CreateTaskWidget(mockOnCreate),
                ),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      await tester.enterText(find.byType(TextFormField).at(0), 'Test Title');
      await tester.enterText(find.byType(TextFormField).at(1), 'Test Content');
      await tester.tap(find.text('Create'));
      await tester.pump();
      expect(createdTask, isNotNull);
      expect(createdTask!.title, 'Test Title');
      expect(createdTask!.content, 'Test Content');
    });

    testWidgets('should pop the context after creating a task', (tester) async {
      final router = GoRouter(
        initialLocation: '/route',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Text('home'),
            routes: [
              GoRoute(
                path: 'route',
                builder: (_, __) => Scaffold(
                  body: CreateTaskWidget(mockOnCreate),
                ),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      expect(find.text('What’s in your mind?'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).at(0), 'title');
      await tester.enterText(find.byType(TextFormField).at(1), 'content');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
    });
  });
}
