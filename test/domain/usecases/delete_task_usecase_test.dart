import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/usecases/delete_task_usecase.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late DeleteTaskUseCase usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = DeleteTaskUseCase(mockRepository);
  });

  test('should call repository to delete task and return Unit', () async {
    when(() => mockRepository.deleteTask(any())).thenAnswer((_) async => const Success(unit));

    final result = await usecase(kTaskEntity.id);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), unit);
    verify(() => mockRepository.deleteTask(kTaskEntity.id)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when the repository fails to delete task', () async {
    when(() => mockRepository.deleteTask(any())).thenAnswer((_) async => Failure(CacheException('')));

    final result = await usecase(kTaskEntity.id);

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheException>());
    verify(() => mockRepository.deleteTask(kTaskEntity.id)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
