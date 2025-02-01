import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';

import '../widgets/empty_widget.dart';
import '../widgets/task_widget.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final store = Modular.get<HomeStore>();

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
              if (store.doneList.isNotEmpty)
                TextButton(
                  onPressed: store.onDeleteAll,
                  child: Text('Delete all', style: TextStyle(color: context.colorScheme.error)),
                ),
            ],
          ),
        ),
        Observer(
          builder: (_) => Expanded(
            child: store.doneList.isEmpty
                ? const EmptyListWidget()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: store.doneList.length,
                    itemBuilder: (_, int index) => TaskWidget(
                      store.doneList[index],
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
