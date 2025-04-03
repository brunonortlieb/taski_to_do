import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final store = injector.get<HomeStore>();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => store.onSearch(searchController.text));
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
        Observer(
          builder: (_) => Expanded(
            child: store.filteredTasks.isEmpty
                ? EmptyListWidget(
                    onCreate: store.todoTasks.isNotEmpty
                        ? null
                        : () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) =>
                                  CreateTaskWidget(store.onCreateTask),
                            );
                          },
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: store.filteredTasks.length,
                    itemBuilder: (_, int index) => TaskWidget(
                      store.filteredTasks[index],
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
