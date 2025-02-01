import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';
import 'package:taski_to_do/core/failures/failure.dart';
import 'package:taski_to_do/data/local/models/task_model.dart';
import 'package:taski_to_do/data/local/repositories/local_task_repository.dart';

class MockBox<T> extends Mock implements Box<T> {}

class FakeTaskModel extends Fake implements TaskModel {}

void main() {
  late LocalTaskRepository repository;
  late MockBox<TaskModel> mockBox;

  setUpAll(() {
    registerFallbackValue(FakeTaskModel());
  });

  setUp(() {
    mockBox = MockBox<TaskModel>();
    repository = LocalTaskRepository(mockBox);
  });

  group('LocalTaskRepository', () {
    final taskEntity = TaskEntity(
      id: '1',
      isDone: false,
      title: 'title',
      content: 'content',
    );
    final taskModel = TaskModel.fromEntity(taskEntity);

    test('putTask - success', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => {});

      final result = await repository.putTask(taskEntity);

      expect(result, isA<Right>());
      verify(() => mockBox.put(
            taskEntity.id,
            any(
                that: predicate<TaskModel>((model) => model.toEntity() == taskEntity // Compara TaskModel convertido para TaskEntity
                    )),
          )).called(1);
    });

    test('putTask - fail', () async {
      when(() => mockBox.put(any(), any())).thenThrow(Exception());

      final result = await repository.putTask(taskEntity);

      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<HiveFailure>()),
        (success) => fail('Expected a HiveFailure, but got a Right'),
      );
    });

    test('getTasks - success', () async {
      when(() => mockBox.values).thenReturn([taskModel]);

      final result = await repository.getTasks();

      expect(result, isA<Right>());
      result.fold((_) {}, (list) => expect(list.length, 1));
    });

    test('getTasks - fail', () async {
      when(() => mockBox.values).thenThrow(Exception());

      final result = await repository.getTasks();

      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<HiveFailure>()),
        (success) => fail('Expected a HiveFailure, but got a Right'),
      );
    });

    test('deleteTask - success', () async {
      when(() => mockBox.delete(any())).thenAnswer((_) async => {});

      final result = await repository.deleteTask(taskEntity);

      expect(result, isA<Right>());
      verify(() => mockBox.delete(taskEntity.id)).called(1);
    });

    test('deleteTask - fail', () async {
      when(() => mockBox.delete(any())).thenThrow(Exception());

      final result = await repository.deleteTask(taskEntity);

      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<HiveFailure>()),
        (success) => fail('Expected a HiveFailure, but got a Right'),
      );
    });

    test('deleteAllTask - success', () async {
      final tasks = [taskEntity];
      when(() => mockBox.deleteAll(any())).thenAnswer((_) async => {});

      final result = await repository.deleteAllTask(tasks);

      expect(result, isA<Right>());
      verify(() => mockBox.deleteAll(tasks.map((e) => e.id))).called(1);
    });

    test('deleteAllTask - fail', () async {
      final tasks = [taskEntity];
      when(() => mockBox.deleteAll(any())).thenThrow(Exception());

      final result = await repository.deleteAllTask(tasks);

      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure, isA<HiveFailure>()),
        (success) => fail('Expected a HiveFailure, but got a Right'),
      );
    });
  });
}
