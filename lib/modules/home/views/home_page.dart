import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<HomeStore>();

  @override
  void initState() {
    store.init();
    WidgetsBinding.instance.addPostFrameCallback((_) => store.buildContext = context);
    super.initState();
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
              Text(store.username),
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
            currentIndex: store.btmNavBarIndex,
            onTap: store.onTapBtmNavBar,
            items: [
              _navBarItem(icon: ImageAssets.todoIcon, label: 'Todo'),
              _navBarItem(icon: ImageAssets.createIcon, label: 'Create'),
              _navBarItem(icon: ImageAssets.searchIcon, label: 'Search'),
              _navBarItem(icon: ImageAssets.doneIcon, label: 'Done'),
            ],
          ),
        ),
      ),
      body: const RouterOutlet(),
    );
  }

  BottomNavigationBarItem _navBarItem({
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ImageIcon(AssetImage(icon)),
      ),
      label: label,
    );
  }
}
