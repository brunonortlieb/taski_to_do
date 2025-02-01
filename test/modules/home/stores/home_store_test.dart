import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mobx/mobx.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';
import 'package:taski_to_do/core/failures/failure.dart';
import 'package:taski_to_do/data/local/repositories/local_task_repository.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';

class MockLocalTaskRepository extends mocktail.Mock implements LocalTaskRepository {}

class MockBuildContext extends mocktail.Mock implements BuildContext {}

class FakeFailure extends mocktail.Fake implements Failure {}

class FakeTaskEntity extends mocktail.Fake implements TaskEntity {}

void main() {
  late HomeStore homeStore;
  late MockLocalTaskRepository mockRepository;
  late MockBuildContext mockContext;

  setUpAll(() {
    mocktail.registerFallbackValue(FakeFailure());
    mocktail.registerFallbackValue(FakeTaskEntity());
  });

  setUp(() {
    mockRepository = MockLocalTaskRepository();
    mockContext = MockBuildContext();
    homeStore = HomeStore(mockRepository);
    homeStore.buildContext = mockContext;
  });

  group('HomeStore', () {
    final taskEntity = TaskEntity(
      id: '1',
      isDone: false,
      title: 'title',
      content: 'content',
    );

    test('init should load tasks and update lists', () async {
      mocktail.when(() => mockRepository.getTasks()).thenAnswer((_) async => Right([taskEntity]));

      await homeStore.init();

      expect(homeStore.todoList.length, 1);
      expect(homeStore.searchList.length, 1);
      expect(homeStore.doneList.length, 0);
    });

    test('onSearch should update searchList based on query', () {
      homeStore.todoList = ObservableList.of([taskEntity]);
      homeStore.onSearch('title');

      expect(homeStore.searchList.length, 1);
      expect(homeStore.searchList.first.title, 'title');
    });

    test('onChangeTask should move task between todoList and doneList', () async {
      homeStore.todoList = ObservableList.of([taskEntity]);
      homeStore.searchList = ObservableList.of([taskEntity]);

      mocktail.when(() => mockRepository.putTask(mocktail.any())).thenAnswer((_) async => const Right(null));

      await homeStore.onChangeTask(taskEntity.copyWith(isDone: true));

      expect(homeStore.todoList.length, 0);
      expect(homeStore.doneList.length, 1);
    });

    test('onDeleteTask should remove task from doneList and searchList', () async {
      homeStore.doneList = ObservableList.of([taskEntity]);
      homeStore.searchList = ObservableList.of([taskEntity]);

      mocktail.when(() => mockRepository.putTask(mocktail.any())).thenAnswer((_) async => const Right(null));

      await homeStore.onDeleteTask(taskEntity);

      expect(homeStore.doneList.length, 0);
      expect(homeStore.searchList.length, 0);
    });

    test('onCreateTask should add task to todoList and searchList', () async {
      mocktail.when(() => mockRepository.putTask(mocktail.any())).thenAnswer((_) async => const Right(null));

      await homeStore.onCreateTask(taskEntity);

      expect(homeStore.todoList.length, 1);
      expect(homeStore.searchList.length, 1);
    });
  });
}
