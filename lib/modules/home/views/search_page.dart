import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski_to_do/core/constants/image_assets.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';
import 'package:taski_to_do/modules/home/widgets/empty_widget.dart';
import 'package:taski_to_do/modules/home/widgets/task_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final store = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 32),
          child: TextField(
            onChanged: store.onSearch,
            controller: store.searchCtrl,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const ImageIcon(AssetImage(ImageAssets.searchAltIcon)),
              suffixIcon: IconButton(
                onPressed: store.searchCtrl.clear,
                icon: const ImageIcon(AssetImage(ImageAssets.clearIcon)),
              ),
            ),
          ),
        ),
        Observer(
          builder: (_) => Expanded(
            child: store.searchList.isEmpty
                ? EmptyListWidget(onCreate: store.todoList.isEmpty ? store.createTask : null)
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: store.searchList.length,
                    itemBuilder: (_, int index) => TaskWidget(
                      store.searchList[index],
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
