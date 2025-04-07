import 'package:flutter/material.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';

class TodoPage extends StatelessWidget {
  final List<TaskEntity> todoTasks;
  final void Function(TaskEntity task) onCreateTask;
  final void Function(TaskEntity task) onUpdateTask;
  final void Function(TaskEntity task) onDeleteTask;

  const TodoPage({
    required this.todoTasks,
    required this.onCreateTask,
    required this.onUpdateTask,
    required this.onDeleteTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasksTodo =
        todoTasks.isEmpty ? 'Create tasks to achieve more.' : 'You’ve got ${todoTasks.length} tasks to do.';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                key: const Key('welcomeMessage'),
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Welcome, ', style: context.textTheme.titleLarge),
                    TextSpan(
                        text: 'Jhon',
                        style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.primary)),
                    TextSpan(text: '.', style: context.textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(tasksTodo, style: context.textTheme.bodyLarge),
            ],
          ),
        ),
        Expanded(
          child: todoTasks.isEmpty
              ? EmptyListWidget(
                  onCreate: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => CreateTaskWidget(onCreateTask),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: todoTasks.length,
                  itemBuilder: (_, int index) => TaskWidget(
                    todoTasks[index],
                    onChanged: onUpdateTask,
                    onDelete: onDeleteTask,
                  ),
                ),
        ),
      ],
    );
  }
}
