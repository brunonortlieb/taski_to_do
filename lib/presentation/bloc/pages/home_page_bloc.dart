import 'package:flutter/material.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/di/injector.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/presentation/tasks/widgets/create_task_widget.dart';

import '../blocs/home_bloc.dart';
import 'done_page_bloc.dart';
import 'search_page_bloc.dart';
import 'todo_page_bloc.dart';

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({super.key});

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  int _currentIndex = 0;

  @override
  void initState() {
    injector.get<HomeBloc>().add(LoadTasksEvent());
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
              const Text('Jhon'), //TODO
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
            _navBarItem(icon: ImageAssets.todoIcon, label: 'Todo'),
            _navBarItem(icon: ImageAssets.createIcon, label: 'Create'),
            _navBarItem(icon: ImageAssets.searchIcon, label: 'Search'),
            _navBarItem(icon: ImageAssets.doneIcon, label: 'Done'),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          TodoPageBloc(),
          SizedBox.shrink(),
          SearchPageBloc(),
          DonePageBloc(),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navBarItem({
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      key: Key(label),
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ImageIcon(AssetImage(icon)),
      ),
      label: label,
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CreateTaskWidget(
          (task) => injector.get<HomeBloc>().add(AddTaskEvent(task)),
        );
      },
    );
  }
}
