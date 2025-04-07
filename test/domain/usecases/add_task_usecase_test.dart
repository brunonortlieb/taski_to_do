import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:taski_to_do/domain/usecases/add_task_usecase.dart';
import 'package:taski_to_do/core/exceptions/cache_exception.dart';

import '../../../testing/entities/task_entity_testing.dart';
import '../../../testing/mocks.dart';

void main() {
  late CreateTaskUseCase usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = CreateTaskUseCase(mockRepository);

    registerFallbackValue(kTaskEntity);
  });

  test('should call repository to add task and return the added task', () async {
    final tAddedTask = kTaskEntity.copyWith(id: 'newId');
    when(() => mockRepository.createTask(any())).thenAnswer((_) async => Success(tAddedTask));

    final result = await usecase(kTaskEntity);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), tAddedTask);
    verify(() => mockRepository.createTask(kTaskEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when the repository fails to add task', () async {
    when(() => mockRepository.createTask(any())).thenAnswer((_) async => Failure(CacheException('')));

    final result = await usecase(kTaskEntity);

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheException>());
    verify(() => mockRepository.createTask(kTaskEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
