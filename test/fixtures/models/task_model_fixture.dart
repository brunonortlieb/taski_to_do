import 'package:taski_to_do/data/local/models/task_model.dart';

class TaskModelFixture {
  static TaskModel createDefault() {
    return TaskModel(
      id: '1',
      isDone: false,
      title: 'title',
      content: 'content',
    );
  }
}
