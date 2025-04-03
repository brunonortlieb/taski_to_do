import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/data/repositories/task_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';
import '../../../testing/models/task_model_testing.dart';

void main() {
  late TaskRepositoryImpl repository;
  late MockTaskDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockTaskDatasource();
    repository = TaskRepositoryImpl(mockDatasource);

    registerFallbackValue(kTaskModel);
  });

  group('getAllTasks', () {
    test('Should return a [List<TaskEntity>] when succeeds', () async {
      when(() => mockDatasource.getAllTasks())
          .thenAnswer((_) async => [kTaskModel]);

      final result = await repository.getAllTasks();

      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<List<TaskEntity>>());
      verify(() => mockDatasource.getAllTasks()).called(1);
    });

    test(
        'Should reuturn a [CacheException] when getAllTasks throws an exception',
        () async {
      when(() => mockDatasource.getAllTasks()).thenThrow(Exception());

      final result = await repository.getAllTasks();

      expect(result.isSuccess(), false);
      expect(result.exceptionOrNull(), isA<CacheException>());
      verify(() => mockDatasource.getAllTasks()).called(1);
    });
  });

  group('addTask', () {
    test('Should return a [TaskEntity] when succeeds', () async {
      when(() => mockDatasource.addTask(any()))
          .thenAnswer((_) async => kTaskModel);

      final result = await repository.addTask(kTaskEntity);

      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<TaskEntity>());
      verify(() => mockDatasource.addTask(any())).called(1);
    });

    test(
        'Should reuturn a [CacheException] when getAllTasks throws an exception',
        () async {
      when(() => mockDatasource.addTask(any())).thenThrow(Exception());

      final result = await repository.addTask(kTaskEntity);

      expect(result.isSuccess(), false);
      expect(result.exceptionOrNull(), isA<CacheException>());
      verify(() => mockDatasource.addTask(any())).called(1);
    });
  });

  group('updateTask', () {
    test('Should return a [TaskEntity] when succeeds', () async {
      when(() => mockDatasource.updateTask(any()))
          .thenAnswer((_) async => kTaskModel);

      final result = await repository.updateTask(kTaskEntity);

      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<TaskEntity>());
      verify(() => mockDatasource.updateTask(any())).called(1);
    });

    test(
        'Should reuturn a [CacheException] when getAllTasks throws an exception',
        () async {
      when(() => mockDatasource.updateTask(any())).thenThrow(Exception());

      final result = await repository.updateTask(kTaskEntity);

      expect(result.isSuccess(), false);
      expect(result.exceptionOrNull(), isA<CacheException>());
      verify(() => mockDatasource.updateTask(any())).called(1);
    });
  });

  group('deleteTask', () {
    test('Should return a [Unit] when succeeds', () async {
      when(() => mockDatasource.deleteTask(any())).thenAnswer((_) async {});

      final result = await repository.deleteTask(kTaskEntity.id);

      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<Unit>());
      verify(() => mockDatasource.deleteTask(any())).called(1);
    });

    test(
        'Should reuturn a [CacheException] when getAllTasks throws an exception',
        () async {
      when(() => mockDatasource.deleteTask(any())).thenThrow(Exception());

      final result = await repository.deleteTask(kTaskEntity.id);

      expect(result.isSuccess(), false);
      expect(result.exceptionOrNull(), isA<CacheException>());
      verify(() => mockDatasource.deleteTask(any())).called(1);
    });
  });

  group('deleteAllTasks', () {
    test('Should return a [Unit] when succeeds', () async {
      when(() => mockDatasource.deleteAllTasks(any())).thenAnswer((_) async {});

      final result = await repository.deleteAllTasks([kTaskEntity.id]);

      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<Unit>());
      verify(() => mockDatasource.deleteAllTasks(any())).called(1);
    });

    test(
        'Should reuturn a [CacheException] when getAllTasks throws an exception',
        () async {
      when(() => mockDatasource.deleteAllTasks(any())).thenThrow(Exception());

      final result = await repository.deleteAllTasks([kTaskEntity.id]);

      expect(result.isSuccess(), false);
      expect(result.exceptionOrNull(), isA<CacheException>());
      verify(() => mockDatasource.deleteAllTasks(any())).called(1);
    });
  });
}
