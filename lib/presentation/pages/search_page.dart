import 'package:flutter/material.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/domain/entities/task_entity.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/widgets/task_widget.dart';

class SearchPage extends StatefulWidget {
  final List<TaskEntity> filteredTasks;
  final List<TaskEntity> todoTasks;
  final void Function(String query) onSearchTasks;
  final void Function(TaskEntity task) onCreateTask;
  final void Function(TaskEntity task) onUpdateTask;
  final void Function(TaskEntity task) onDeleteTask;

  const SearchPage({
    required this.filteredTasks,
    required this.todoTasks,
    required this.onSearchTasks,
    required this.onCreateTask,
    required this.onUpdateTask,
    required this.onDeleteTask,
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController
        .addListener(() => widget.onSearchTasks(searchController.text));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
          child: TextField(
            controller: searchController,
            style: context.textTheme.bodyMedium
                ?.copyWith(color: context.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon:
                  const ImageIcon(AssetImage(ImageAssets.searchAltIcon)),
              suffixIcon: IconButton(
                key: const Key('clearSearchButton'),
                onPressed: searchController.clear,
                icon: const ImageIcon(AssetImage(ImageAssets.clearIcon)),
              ),
            ),
          ),
        ),
        Expanded(
          child: widget.filteredTasks.isEmpty
              ? EmptyListWidget(
                  onCreate: widget.todoTasks.isNotEmpty
                      ? null
                      : () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) =>
                                CreateTaskWidget(widget.onCreateTask),
                          );
                        },
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: widget.filteredTasks.length,
                  itemBuilder: (_, int index) => TaskWidget(
                    widget.filteredTasks[index],
                    onChanged: widget.onUpdateTask,
                    onDelete: widget.onDeleteTask,
                  ),
                ),
        ),
      ],
    );
  }
}
