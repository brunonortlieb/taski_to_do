import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/data/datasources/local/task_local_datasoruce.dart';
import 'package:taski_to_do/data/models/task_model.dart';

import '../../../../testing/mocks.dart';
import '../../../../testing/models/task_model_testing.dart';

void main() {
  late TaskLocalDatasourceImpl dataSource;
  late MockHiveInterface mockHive;
  late MockBox<TaskModel> mockBox;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox<TaskModel>();
    dataSource = TaskLocalDatasourceImpl(mockHive);

    registerFallbackValue(kTaskModel);

    when(() => mockHive.registerAdapter(TaskModelAdapter())).thenAnswer((_) {});
    when(() => mockHive.openBox<TaskModel>(any())).thenAnswer((_) async => mockBox);
  });

  group('TaskLocalDatasourceImpl', () {
    test('should add a task to the box', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await dataSource.addTask(kTaskModel);

      verify(() => mockBox.put(any(), any())).called(1);
    });

    test('should update a task in the box', () async {
      when(() => mockBox.containsKey(kTaskModel.id)).thenReturn(true);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await dataSource.updateTask(kTaskModel);

      verify(() => mockBox.put(any(), any())).called(1);
    });

    test('should throw a exception when task dont exists', () async {
      when(() => mockBox.containsKey(kTaskModel.id)).thenReturn(false);

      expect(() async => await dataSource.updateTask(kTaskModel), throwsA(isA<Exception>()));

      verifyNever(() => mockBox.put(any(), any()));
    });

    test('should delete a task from the box', () async {
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      await dataSource.deleteTask(kTaskModel);

      verify(() => mockBox.delete(any())).called(1);
    });

    test('should return all tasks from the box', () async {
      final tasks = [kTaskModel];
      when(() => mockBox.values).thenReturn(tasks);

      final result = await dataSource.getAllTasks();

      expect(result, equals(tasks));
      verify(() => mockBox.values).called(1);
    });

    test('should delete multiple tasks from the box', () async {
      final tasks = [kTaskModel];
      final ids = tasks.map((e) => e.id).toList();
      when(() => mockBox.deleteAll(any())).thenAnswer((_) async {});

      await dataSource.deleteAllTasks(tasks);

      verify(() => mockBox.deleteAll(ids)).called(1);
    });
  });
}
