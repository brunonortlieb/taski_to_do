import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/mobx/home_store.dart';
import 'package:taski_to_do/presentation/widgets/create_task_widget.dart';
import 'package:taski_to_do/presentation/widgets/custom_nav_bar_item.dart';

import 'done_page.dart';
import 'search_page.dart';
import 'todo_page.dart';

class HomePageMobx extends StatefulWidget {
  const HomePageMobx({super.key});

  @override
  State<HomePageMobx> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageMobx> {
  final store = injector.get<HomeStore>();

  @override
  void initState() {
    store.init();
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _showCreateTaskBottomSheet(context);
    } else {
      store.setCurrentIndex(index);
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
      bottomNavigationBar: Observer(
        builder: (_) => Container(
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
            currentIndex: store.currentIndex,
            onTap: _onItemTapped,
            items: [
              customNavBarItem(iconPath: ImageAssets.todoIcon, label: 'Todo'),
              customNavBarItem(
                  iconPath: ImageAssets.createIcon, label: 'Create'),
              customNavBarItem(
                  iconPath: ImageAssets.searchIcon, label: 'Search'),
              customNavBarItem(iconPath: ImageAssets.doneIcon, label: 'Done'),
            ],
          ),
        ),
      ),
      body: Observer(
        builder: (_) => IndexedStack(
          index: store.currentIndex,
          children: [
            TodoPage(
              todoTasks: store.todoTasks,
              onCreateTask: store.createTask,
              onUpdateTask: store.updateTask,
              onDeleteTask: store.deleteTask,
            ),
            const SizedBox.shrink(),
            SearchPage(
              todoTasks: store.todoTasks,
              filteredTasks: store.filteredTasks,
              onCreateTask: store.createTask,
              onUpdateTask: store.updateTask,
              onDeleteTask: store.deleteTask,
              onSearchTasks: store.searchTasks,
            ),
            DonePage(
              doneTasks: store.doneTasks,
              onUpdateTask: store.updateTask,
              onDeleteTask: store.deleteTask,
              onDeleteAllTasks: store.deleteAllTasks,
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CreateTaskWidget(store.createTask);
      },
    );
  }
}
