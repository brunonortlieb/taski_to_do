import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/usecases/get_all_tasks_usecase.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late GetAllTasksUseCase usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = GetAllTasksUseCase(mockRepository);
  });

  test('should get list of tasks from the repository', () async {
    final tTaskList = [kTaskEntity, kTaskEntity.copyWith(id: '2')];
    when(() => mockRepository.getAllTasks()).thenAnswer((_) async => Success(tTaskList));

    final result = await usecase();

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), tTaskList);
    verify(() => mockRepository.getAllTasks()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when the repository fails', () async {
    when(() => mockRepository.getAllTasks()).thenAnswer((_) async => Failure(CacheException('')));

    final result = await usecase();

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheException>());
    verify(() => mockRepository.getAllTasks()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
