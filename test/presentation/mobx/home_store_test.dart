import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/presentation/mobx/home_store.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late HomeStore store;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late MockCreateTaskUseCase mockCreateTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockDeleteAllTasksUseCase mockDeleteAllTasksUseCase;

  setUp(() {
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    mockCreateTaskUseCase = MockCreateTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockDeleteAllTasksUseCase = MockDeleteAllTasksUseCase();
    store = HomeStore(
      mockGetAllTasksUseCase,
      mockCreateTaskUseCase,
      mockUpdateTaskUseCase,
      mockDeleteTaskUseCase,
      mockDeleteAllTasksUseCase,
    );

    registerFallbackValue(kTaskEntity);
  });

  test('should initialize with tasks from the repository', () async {
    when(() => mockGetAllTasksUseCase()).thenAnswer((_) async => Success([kTaskEntity]));

    await store.init();

    expect(store.todoTasks.length, equals(1));
    expect(store.todoTasks.first, equals(kTaskEntity));
    expect(store.filteredTasks.length, equals(1));
    expect(store.doneTasks.isEmpty, isTrue);
    verify(() => mockGetAllTasksUseCase()).called(1);
    verifyNoMoreInteractions(mockGetAllTasksUseCase);
  });

  test('should handle failure when initializing tasks', () async {
    when(() => mockGetAllTasksUseCase()).thenAnswer((_) async => Failure(Exception()));

    await store.init();

    expect(store.todoTasks.isEmpty, isTrue);
    expect(store.filteredTasks.isEmpty, isTrue);
    expect(store.doneTasks.isEmpty, isTrue);
    verify(() => mockGetAllTasksUseCase()).called(1);
    verifyNoMoreInteractions(mockGetAllTasksUseCase);
  });

  test('should update currentIndex correctly', () {
    store.setCurrentIndex(1);

    expect(store.currentIndex, equals(1));
  });

  test('should filter filteredTasks on search', () {
    store.allTasks.addAll([kTaskEntity]);

    store.searchTasks('title');

    expect(store.filteredTasks.length, equals(1));
    expect(store.filteredTasks.first, equals(kTaskEntity));
  });

  test('should delete all done tasks', () async {
    final task = kTaskEntity.copyWith(id: '11');
    store.allTasks.addAll([task, kTaskEntity]);
    when(() => mockDeleteAllTasksUseCase(any())).thenAnswer((_) async => const Success(unit));

    await store.deleteAllTasks([task]);

    expect(store.allTasks.length, equals(1));
    expect(store.filteredTasks.length, equals(1));
    verify(() => mockDeleteAllTasksUseCase([task.id])).called(1);
    verifyNoMoreInteractions(mockDeleteAllTasksUseCase);
  });

  test('should toggle task status and update lists', () async {
    store.allTasks.addAll([kTaskEntity]);
    when(() => mockUpdateTaskUseCase(any())).thenAnswer((_) async => Success(kTaskEntity.copyWith(isDone: true)));

    await store.updateTask(kTaskEntity.copyWith(isDone: true));

    expect(store.todoTasks.isEmpty, isTrue);
    expect(store.doneTasks.length, equals(1));
    expect(store.filteredTasks.first.isDone, isTrue);
    verify(() => mockUpdateTaskUseCase(any())).called(1);
    verifyNoMoreInteractions(mockUpdateTaskUseCase);
  });

  test('should delete a task and update lists', () async {
    store.allTasks.addAll([kTaskEntity]);
    when(() => mockDeleteTaskUseCase(any())).thenAnswer((_) async => const Success(unit));

    await store.deleteTask(kTaskEntity);

    expect(store.todoTasks.isEmpty, isTrue);
    expect(store.filteredTasks.isEmpty, isTrue);
    expect(store.doneTasks.isEmpty, isTrue);
    verify(() => mockDeleteTaskUseCase(any())).called(1);
    verifyNoMoreInteractions(mockDeleteTaskUseCase);
  });

  test('should create a new task and update lists', () async {
    when(() => mockCreateTaskUseCase(any())).thenAnswer((_) async => Success(kTaskEntity));

    await store.createTask(kTaskEntity);

    expect(store.todoTasks.length, equals(1));
    expect(store.filteredTasks.length, equals(1));
    verify(() => mockCreateTaskUseCase(any())).called(1);
    verifyNoMoreInteractions(mockCreateTaskUseCase);
  });
}
