import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/usecases/delete_all_tasks_usecase.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late DeleteAllTasksUseCase usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = DeleteAllTasksUseCase(mockRepository);
  });

  test('should call repository to delete multiple tasks and return Unit', () async {
    final tTaskIds = [kTaskEntity.id, '5', '6'];
    when(() => mockRepository.deleteAllTasks(any())).thenAnswer((_) async => const Success(unit));

    final result = await usecase(tTaskIds);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), unit);
    verify(() => mockRepository.deleteAllTasks(tTaskIds)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Unit immediately if taskIds list is empty', () async {
    final List<String> emptyList = [];

    final result = await usecase(emptyList);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), unit);
    verifyNever(() => mockRepository.deleteAllTasks(any()));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when the repository fails to delete tasks', () async {
    when(() => mockRepository.deleteAllTasks(any())).thenAnswer((_) async => Failure(CacheException('')));

    final result = await usecase([kTaskEntity.id]);

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheException>());
    verify(() => mockRepository.deleteAllTasks([kTaskEntity.id])).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
