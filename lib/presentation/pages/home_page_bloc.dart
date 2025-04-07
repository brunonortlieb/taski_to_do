import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/widgets/custom_nav_bar_item.dart';

import '../bloc/home_bloc.dart';
import 'done_page.dart';
import 'search_page.dart';
import 'todo_page.dart';

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({super.key});

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  final bloc = injector.get<HomeBloc>();
  int _currentIndex = 0;

  @override
  void initState() {
    bloc.add(LoadTasksEvent());
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _showCreateTaskBottomSheet(context);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              ImageIcon(
                const AssetImage(ImageAssets.taskiIcon),
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Expanded(child: Text('Taski')),
              const Text('Jhon'),
              const SizedBox(width: 14),
              CircleAvatar(radius: 21, child: Image.asset(ImageAssets.avatar)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colorScheme.surfaceContainerLow,
              width: 2,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            customNavBarItem(iconPath: ImageAssets.todoIcon, label: 'Todo'),
            customNavBarItem(iconPath: ImageAssets.createIcon, label: 'Create'),
            customNavBarItem(iconPath: ImageAssets.searchIcon, label: 'Search'),
            customNavBarItem(iconPath: ImageAssets.doneIcon, label: 'Done'),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, TaskState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TaskLoadedState) {
            return IndexedStack(
              index: _currentIndex,
              children: [
                TodoPage(
                  todoTasks: state.todoTasks,
                  onCreateTask: (task) => bloc.add(CreateTaskEvent(task)),
                  onUpdateTask: (task) => bloc.add(UpdateTaskEvent(task)),
                  onDeleteTask: (task) => bloc.add(DeleteTaskEvent(task)),
                ),
                const SizedBox.shrink(),
                SearchPage(
                  filteredTasks: state.filteredTasks,
                  todoTasks: state.todoTasks,
                  onCreateTask: (task) => bloc.add(CreateTaskEvent(task)),
                  onUpdateTask: (task) => bloc.add(UpdateTaskEvent(task)),
                  onDeleteTask: (task) => bloc.add(DeleteTaskEvent(task)),
                  onSearchTasks: (task) => bloc.add(SearchTasksEvent(task)),
                ),
                DonePage(
                  doneTasks: state.doneTasks,
                  onUpdateTask: (task) => bloc.add(UpdateTaskEvent(task)),
                  onDeleteTask: (task) => bloc.add(DeleteTaskEvent(task)),
                  onDeleteAllTasks: (tasks) => bloc.add(DeleteAllTaskEvent(tasks)),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CreateTaskWidget(
          (task) => bloc.add(CreateTaskEvent(task)),
        );
      },
    );
  }
}
