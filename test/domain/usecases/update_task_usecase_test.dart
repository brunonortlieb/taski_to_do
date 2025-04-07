import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/usecases/update_task_usecase.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late UpdateTaskUseCase usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = UpdateTaskUseCase(mockRepository);

    registerFallbackValue(kTaskEntity);
  });

  test('should call repository to update task and return the updated task', () async {
    when(() => mockRepository.updateTask(any())).thenAnswer((_) async => Success(kTaskEntity));

    final result = await usecase(kTaskEntity);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), kTaskEntity);
    verify(() => mockRepository.updateTask(kTaskEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when the repository fails to update task', () async {
    when(() => mockRepository.updateTask(any())).thenAnswer((_) async => Failure(CacheException('')));

    final result = await usecase(kTaskEntity);

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheException>());
    verify(() => mockRepository.updateTask(kTaskEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
