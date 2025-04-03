import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

import '../blocs/home_bloc.dart';

class TodoPageBloc extends StatelessWidget {
  const TodoPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = injector.get<HomeBloc>();

    return BlocBuilder<HomeBloc, TaskState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is TaskLoadedState) {
          final tasksTodo = state.todoTasks.isEmpty
              ? 'Create tasks to achieve more.'
              : 'You’ve got ${state.todoTasks.length} tasks to do.';

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
                          TextSpan(
                              text: 'Welcome, ',
                              style: context.textTheme.titleLarge),
                          TextSpan(
                              text: 'Jhon',
                              style: context.textTheme.titleLarge?.copyWith(
                                  color: context.colorScheme.primary)),
                          TextSpan(
                              text: '.', style: context.textTheme.titleLarge),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(tasksTodo, style: context.textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: state.todoTasks.isEmpty
                    ? EmptyListWidget(
                        onCreate: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => CreateTaskWidget(
                              (task) => bloc.add(AddTaskEvent(task))),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemCount: state.todoTasks.length,
                        itemBuilder: (_, int index) => TaskWidget(
                          state.todoTasks[index],
                          onChanged: (task) => bloc.add(UpdateTaskEvent(task)),
                          onDelete: (task) => bloc.add(DeleteTaskEvent(task)),
                        ),
                      ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
