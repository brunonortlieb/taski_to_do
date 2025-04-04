import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/presentation/mobx/home_store.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

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
      when(() => mockRepository.getAllTasks())
          .thenAnswer((_) async => Success([kTaskEntity]));

      await store.init();

      expect(store.todoTasks.length, equals(1));
      expect(store.todoTasks.first, equals(kTaskEntity));
      expect(store.filteredTasks.length, equals(1));
      expect(store.doneTasks.isEmpty, isTrue);
      verify(() => mockRepository.getAllTasks()).called(1);
    });

    test('should handle failure when initializing tasks', () async {
      when(() => mockRepository.getAllTasks())
          .thenAnswer((_) async => Failure(Exception()));

      await store.init();

      expect(store.todoTasks.isEmpty, isTrue);
      expect(store.filteredTasks.isEmpty, isTrue);
      expect(store.doneTasks.isEmpty, isTrue);
      verify(() => mockRepository.getAllTasks()).called(1);
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
      when(() => mockRepository.deleteAllTasks(any()))
          .thenAnswer((_) async => const Success(unit));

      await store.deleteAllTasks([task]);

      expect(store.allTasks.length, equals(1));
      expect(store.filteredTasks.length, equals(1));
      verify(() => mockRepository.deleteAllTasks(any())).called(1);
    });

    test('should toggle task status and update lists', () async {
      store.allTasks.addAll([kTaskEntity]);
      when(() => mockRepository.updateTask(any()))
          .thenAnswer((_) async => Success(kTaskEntity.copyWith(isDone: true)));

      await store.updateTask(kTaskEntity.copyWith(isDone: true));

      expect(store.todoTasks.isEmpty, isTrue);
      expect(store.doneTasks.length, equals(1));
      expect(store.filteredTasks.first.isDone, isTrue);
      verify(() => mockRepository.updateTask(any())).called(1);
    });

    test('should delete a task and update lists', () async {
      store.allTasks.addAll([kTaskEntity]);
      when(() => mockRepository.deleteTask(any()))
          .thenAnswer((_) async => const Success(unit));

      final result = await store.deleteTask(kTaskEntity);

      expect(result.isSuccess(), isTrue);
      expect(store.todoTasks.isEmpty, isTrue);
      expect(store.filteredTasks.isEmpty, isTrue);
      expect(store.doneTasks.isEmpty, isTrue);
      verify(() => mockRepository.deleteTask(any())).called(1);
    });

    test('should create a new task and update lists', () async {
      when(() => mockRepository.addTask(any()))
          .thenAnswer((_) async => Success(kTaskEntity));

      final result = await store.createTask(kTaskEntity);

      expect(result.isSuccess(), isTrue);
      expect(store.todoTasks.length, equals(1));
      expect(store.filteredTasks.length, equals(1));
      verify(() => mockRepository.addTask(any())).called(1);
    });
  });
}
