import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski_to_do/data/local/repositories/local_task_repository.dart';
import 'package:taski_to_do/modules/home/stores/home_store.dart';
import 'package:taski_to_do/modules/home/views/done_page.dart';
import 'package:taski_to_do/modules/home/views/search_page.dart';
import 'package:taski_to_do/modules/home/views/todo_page.dart';

import 'views/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(LocalTaskRepository.init);
    i.addSingleton(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage(), children: [
      ChildRoute('/todo', child: (context) => const TodoPage(), transition: TransitionType.noTransition),
      ChildRoute('/search', child: (context) => const SearchPage(), transition: TransitionType.noTransition),
      ChildRoute('/done', child: (context) => const DonePage(), transition: TransitionType.noTransition),
    ]);
  }
}
