import 'package:flutter/material.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';

class DonePage extends StatelessWidget {
  final List<TaskEntity> doneTasks;
  final void Function(TaskEntity task) onUpdateTask;
  final void Function(TaskEntity task) onDeleteTask;
  final void Function(List<TaskEntity> tasks) onDeleteAllTasks;

  const DonePage({
    required this.doneTasks,
    required this.onUpdateTask,
    required this.onDeleteTask,
    required this.onDeleteAllTasks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Completed Tasks', style: context.textTheme.titleLarge),
              if (doneTasks.isNotEmpty)
                TextButton(
                  onPressed: () => onDeleteAllTasks(doneTasks),
                  child: Text('Delete all',
                      style: TextStyle(color: context.colorScheme.error)),
                ),
            ],
          ),
        ),
        Expanded(
          child: doneTasks.isEmpty
              ? const EmptyListWidget()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: doneTasks.length,
                  itemBuilder: (_, int index) => TaskWidget(
                    doneTasks[index],
                    onChanged: onUpdateTask,
                    onDelete: onDeleteTask,
                  ),
                ),
        ),
      ],
    );
  }
}
