import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/empty_widget.dart';
import 'package:taski_to_do/presentation/tasks/widgets/task_widget.dart';

import '../blocs/home_bloc.dart';

class SearchPageBloc extends StatefulWidget {
  const SearchPageBloc({super.key});

  @override
  State<SearchPageBloc> createState() => _SearchPageBlocState();
}

class _SearchPageBlocState extends State<SearchPageBloc> {
  final bloc = injector.get<HomeBloc>();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => bloc.add(SearchTasksEvent(searchController.text)));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, TaskState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is TaskLoadedState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
                child: TextField(
                  controller: searchController,
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const ImageIcon(AssetImage(ImageAssets.searchAltIcon)),
                    suffixIcon: IconButton(
                      key: const Key('clearSearchButton'),
                      onPressed: searchController.clear,
                      icon: const ImageIcon(AssetImage(ImageAssets.clearIcon)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: state.filteredTasks.isEmpty
                    ? EmptyListWidget(
                        onCreate: state.todoTasks.isNotEmpty
                            ? null
                            : () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) => CreateTaskWidget((task) => bloc.add(AddTaskEvent(task))),
                                );
                              },
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemCount: state.filteredTasks.length,
                        itemBuilder: (_, int index) => TaskWidget(
                          state.filteredTasks[index],
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
