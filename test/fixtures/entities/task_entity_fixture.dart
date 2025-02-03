import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';

class MockTaskEntity extends Mock implements TaskEntity {}

class FakeTaskEntity extends Fake implements TaskEntity {}

class TaskEntityFixture {
  static TaskEntity createDefault() {
    return TaskEntity(
      id: '1',
      isDone: false,
      title: 'title',
      content: 'content',
    );
  }

  static TaskEntity createDefaultMock() {
    TaskEntity mockTask = MockTaskEntity();
    when(() => mockTask.title).thenReturn('title');
    when(() => mockTask.content).thenReturn('content');
    when(() => mockTask.isDone).thenReturn(false);
    when(() => mockTask.copyWith(isDone: any(named: 'isDone'))).thenReturn(mockTask);

    return mockTask;
  }

  static FakeTaskEntity createFake() => FakeTaskEntity();
}
