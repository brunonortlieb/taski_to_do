import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';
import 'package:taski_to_do/modules/home/widgets/empty_widget.dart';

import '../widgets/task_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final store = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Welcome, ', style: context.textTheme.titleLarge),
                    TextSpan(text: store.username, style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.primary)),
                    TextSpan(text: '.', style: context.textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(store.tasksTodo, style: context.textTheme.bodyLarge),
            ],
          ),
        ),
        Observer(
          builder: (_) => Expanded(
            child: store.todoList.isEmpty
                ? EmptyListWidget(onCreate: store.createTask)
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: store.todoList.length,
                    itemBuilder: (_, int index) => TaskWidget(
                      store.todoList[index],
                      onChanged: store.onChangeTask,
                      onDelete: store.onDeleteTask,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
