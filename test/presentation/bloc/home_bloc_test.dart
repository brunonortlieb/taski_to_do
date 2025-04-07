import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/bloc/home_bloc.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late HomeBloc homeBloc;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late MockCreateTaskUseCase mockCreateTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockDeleteAllTasksUseCase mockDeleteAllTasksUseCase;

  final tTask1 = TaskEntity(id: '1', title: 'title 1', content: 'content 1');
  final tTask2 = TaskEntity(id: '2', title: 'title 2', content: 'content 2');
  final tTask3 = TaskEntity(id: '3', title: 'title 3', content: 'content 3');
  final tTaskList = [tTask1, tTask2];

  final tCacheException = CacheException('CacheException');

  setUp(() {
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    mockCreateTaskUseCase = MockCreateTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockDeleteAllTasksUseCase = MockDeleteAllTasksUseCase();

    homeBloc = HomeBloc(
      mockGetAllTasksUseCase,
      mockCreateTaskUseCase,
      mockUpdateTaskUseCase,
      mockDeleteTaskUseCase,
      mockDeleteAllTasksUseCase,
    );

    registerFallbackValue(kTaskEntity);
    registerFallbackValue(<String>[]);
  });

  tearDown(() {
    homeBloc.close();
  });

  test('initial state should be TaskLoadingState', () {
    expect(homeBloc.state, TaskLoadingState());
  });

  group('LoadTasksEvent', () {
    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadingState, TaskLoadedState] when GetAllTasksUseCase succeeds',
      build: () {
        when(() => mockGetAllTasksUseCase()).thenAnswer((_) async => Success(tTaskList));
        return homeBloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: tTaskList,
          todoTasks: [tTask1],
          doneTasks: [tTask2],
          filteredTasks: tTaskList,
          filterQuery: '',
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllTasksUseCase()).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadingState, TaskErrorState] when GetAllTasksUseCase fails',
      build: () {
        when(() => mockGetAllTasksUseCase()).thenAnswer((_) async => Failure(tCacheException));
        return homeBloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () => <TaskState>[
        TaskErrorState(tCacheException.toString()),
      ],
      verify: (_) {
        verify(() => mockGetAllTasksUseCase()).called(1);
      },
    );
  });

  group('CreateTaskEvent', () {
    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] with new task when AddTaskUseCase succeeds',
      build: () {
        when(() => mockCreateTaskUseCase(any())).thenAnswer((_) async => Success(tTask3));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(CreateTaskEvent(tTask3)),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: [tTask1, tTask2, tTask3],
          todoTasks: [tTask1, tTask3],
          doneTasks: [tTask2],
          filteredTasks: [tTask1, tTask2, tTask3],
          filterQuery: '',
        ),
      ],
      verify: (_) {
        verify(() => mockCreateTaskUseCase(tTask3)).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskErrorState] when AddTaskUseCase fails',
      build: () {
        when(() => mockCreateTaskUseCase(any())).thenAnswer((_) async => Failure(tCacheException));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(CreateTaskEvent(tTask3)),
      expect: () => <TaskState>[
        TaskErrorState(tCacheException.toString()),
      ],
      verify: (_) {
        verify(() => mockCreateTaskUseCase(tTask3)).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should not emit new state if current state is not TaskLoadedState',
      build: () => homeBloc,
      act: (bloc) => bloc.add(CreateTaskEvent(tTask3)),
      expect: () => <TaskState>[],
      verify: (_) {
        verifyNever(() => mockCreateTaskUseCase(any()));
      },
    );
  });

  group('UpdateTaskEvent', () {
    final taskToUpdate = tTask1.copyWith(isDone: true);

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] with updated task when UpdateTaskUseCase succeeds',
      build: () {
        when(() => mockUpdateTaskUseCase(any())).thenAnswer((_) async => Success(taskToUpdate));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(UpdateTaskEvent(taskToUpdate)),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: [tTask1.copyWith(isDone: true), tTask2],
          todoTasks: const [],
          doneTasks: [taskToUpdate, tTask2],
          filteredTasks: [tTask1.copyWith(isDone: true), tTask2],
          filterQuery: '',
        ),
      ],
      verify: (_) {
        verify(() => mockUpdateTaskUseCase(taskToUpdate)).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskErrorState] when UpdateTaskUseCase fails',
      build: () {
        when(() => mockUpdateTaskUseCase(any())).thenAnswer((_) async => Failure(tCacheException));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(UpdateTaskEvent(taskToUpdate)),
      expect: () => <TaskState>[
        TaskErrorState(tCacheException.toString()),
      ],
      verify: (_) {
        verify(() => mockUpdateTaskUseCase(taskToUpdate)).called(1);
      },
    );
  });

  group('DeleteTaskEvent', () {
    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] without deleted task when DeleteTaskUseCase succeeds',
      build: () {
        when(() => mockDeleteTaskUseCase(any())).thenAnswer((_) async => const Success(unit));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(DeleteTaskEvent(tTask1)),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: [tTask2],
          todoTasks: const [],
          doneTasks: [tTask2],
          filteredTasks: [tTask2],
          filterQuery: '',
        ),
      ],
      verify: (_) {
        verify(() => mockDeleteTaskUseCase(tTask1.id)).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskErrorState] when DeleteTaskUseCase fails',
      build: () {
        when(() => mockDeleteTaskUseCase(any())).thenAnswer((_) async => Failure(tCacheException));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(DeleteTaskEvent(tTask1)),
      expect: () => <TaskState>[
        TaskErrorState(tCacheException.toString()),
      ],
      verify: (_) {
        verify(() => mockDeleteTaskUseCase(tTask1.id)).called(1);
      },
    );
  });

  group('DeleteAllTaskEvent', () {
    final tasksToDelete = [tTask2];
    final taskIdsToDelete = tasksToDelete.map((e) => e.id).toList();

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] without deleted tasks when DeleteAllTasksUseCase succeeds',
      build: () {
        when(() => mockDeleteAllTasksUseCase(any())).thenAnswer((_) async => const Success(unit));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(DeleteAllTaskEvent(tasksToDelete)),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: [tTask1],
          todoTasks: [tTask1],
          doneTasks: const [],
          filteredTasks: [tTask1],
          filterQuery: '',
        ),
      ],
      verify: (_) {
        verify(() => mockDeleteAllTasksUseCase(taskIdsToDelete)).called(1);
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskErrorState] when DeleteAllTasksUseCase fails',
      build: () {
        when(() => mockDeleteAllTasksUseCase(any())).thenAnswer((_) async => Failure(tCacheException));
        return homeBloc;
      },
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(DeleteAllTaskEvent(tasksToDelete)),
      expect: () => <TaskState>[
        TaskErrorState(tCacheException.toString()),
      ],
      verify: (_) {
        verify(() => mockDeleteAllTasksUseCase(taskIdsToDelete)).called(1);
      },
    );
  });

  group('SearchTasksEvent', () {
    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] with updated filterQuery and filteredTasks',
      build: () => homeBloc,
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(const SearchTasksEvent('title 1')),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: tTaskList,
          todoTasks: [tTask1],
          doneTasks: [tTask2],
          filteredTasks: [tTask1],
          filterQuery: 'Task 1',
        ),
      ],
      verify: (_) {
        verifyNever(() => mockGetAllTasksUseCase());
        verifyNever(() => mockCreateTaskUseCase(any()));
        verifyNever(() => mockUpdateTaskUseCase(any()));
        verifyNever(() => mockDeleteTaskUseCase(any()));
        verifyNever(() => mockDeleteAllTasksUseCase(any()));
      },
    );

    blocTest<HomeBloc, TaskState>(
      'should emit [TaskLoadedState] with empty filteredTasks if no match',
      build: () => homeBloc,
      seed: () => TaskLoadedState(
        allTasks: tTaskList,
        todoTasks: [tTask1],
        doneTasks: [tTask2],
        filteredTasks: tTaskList,
        filterQuery: '',
      ),
      act: (bloc) => bloc.add(const SearchTasksEvent('NonExistent')),
      expect: () => <TaskState>[
        TaskLoadedState(
          allTasks: tTaskList,
          todoTasks: [tTask1],
          doneTasks: [tTask2],
          filteredTasks: const [],
          filterQuery: 'NonExistent',
        ),
      ],
    );

    blocTest<HomeBloc, TaskState>(
      'should not emit new state if current state is not TaskLoadedState',
      build: () => homeBloc,
      act: (bloc) => bloc.add(const SearchTasksEvent('test')),
      expect: () => <TaskState>[],
    );
  });
}
