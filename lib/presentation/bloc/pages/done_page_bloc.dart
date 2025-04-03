import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

import '../blocs/home_bloc.dart';

class DonePageBloc extends StatelessWidget {
  const DonePageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = injector.get<HomeBloc>();

    return BlocBuilder<HomeBloc, TaskState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is TaskLoadedState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Completed Tasks',
                        style: context.textTheme.titleLarge),
                    if (state.doneTasks.isNotEmpty)
                      TextButton(
                        onPressed: () =>
                            bloc.add(DeleteAllTaskEvent(state.doneTasks)),
                        child: Text('Delete all',
                            style: TextStyle(color: context.colorScheme.error)),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: state.doneTasks.isEmpty
                    ? const EmptyListWidget()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemCount: state.doneTasks.length,
                        itemBuilder: (_, int index) => TaskWidget(
                          state.doneTasks[index],
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
