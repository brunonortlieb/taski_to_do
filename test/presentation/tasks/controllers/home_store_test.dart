import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';

import '../../../../testing/entities/task_entity_testing.dart';
import '../../../../testing/mocks.dart';

void main() {
  late HomeStore store;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    store = HomeStore(mockRepository);

    registerFallbackValue(kTaskEntity);
  });

  group('HomeStore', () {
    test('should initialize with tasks from the repository', () async {
      when(() => mockRepository.getAllTasks()).thenAnswer((_) async => Success([kTaskEntity]));

      await store.init();

      expect(store.todoList.length, equals(1));
      expect(store.todoList.first, equals(kTaskEntity));
      expect(store.searchList.length, equals(1));
      expect(store.doneList.isEmpty, isTrue);
      verify(() => mockRepository.getAllTasks()).called(1);
    });

    test('should handle failure when initializing tasks', () async {
      when(() => mockRepository.getAllTasks()).thenAnswer((_) async => Failure(Exception()));

      await store.init();

      expect(store.todoList.isEmpty, isTrue);
      expect(store.searchList.isEmpty, isTrue);
      expect(store.doneList.isEmpty, isTrue);
      verify(() => mockRepository.getAllTasks()).called(1);
    });

    test('should update currentIndex correctly', () {
      store.setCurrentIndex(1);

      expect(store.currentIndex, equals(1));
    });

    test('should filter searchList on search', () {
      store.taskList.addAll([kTaskEntity]);

      store.onSearch('title');

      expect(store.searchList.length, equals(1));
      expect(store.searchList.first, equals(kTaskEntity));
    });

    test('should delete all done tasks', () async {
      final task = kTaskEntity.copyWith(isDone: true);
      store.taskList.addAll([task]);
      when(() => mockRepository.deleteAllTasks(any())).thenAnswer((_) async => const Success(unit));

      await store.onDeleteDoneTasks();

      expect(store.doneList.isEmpty, isTrue);
      expect(store.searchList.isEmpty, isTrue);
      verify(() => mockRepository.deleteAllTasks(any())).called(1);
    });

    test('should toggle task status and update lists', () async {
      store.taskList.addAll([kTaskEntity]);
      when(() => mockRepository.updateTask(any())).thenAnswer((_) async => Success(kTaskEntity.copyWith(isDone: true)));

      await store.onChangeTask(kTaskEntity.copyWith(isDone: true));

      expect(store.todoList.isEmpty, isTrue);
      expect(store.doneList.length, equals(1));
      expect(store.searchList.first.isDone, isTrue);
      verify(() => mockRepository.updateTask(any())).called(1);
    });

    test('should delete a task and update lists', () async {
      store.taskList.addAll([kTaskEntity]);
      when(() => mockRepository.deleteTask(any())).thenAnswer((_) async => const Success(unit));

      final result = await store.onDeleteTask(kTaskEntity);

      expect(result.isSuccess(), isTrue);
      expect(store.todoList.isEmpty, isTrue);
      expect(store.searchList.isEmpty, isTrue);
      expect(store.doneList.isEmpty, isTrue);
      verify(() => mockRepository.deleteTask(any())).called(1);
    });

    test('should create a new task and update lists', () async {
      when(() => mockRepository.addTask(any())).thenAnswer((_) async => Success(kTaskEntity));

      final result = await store.onCreateTask(kTaskEntity);

      expect(result.isSuccess(), isTrue);
      expect(store.todoList.length, equals(1));
      expect(store.searchList.length, equals(1));
      verify(() => mockRepository.addTask(any())).called(1);
    });
  });
}
