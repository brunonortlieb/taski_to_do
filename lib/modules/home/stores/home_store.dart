import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:taski_to_do/core/entities/task_entity.dart';
import 'package:taski_to_do/core/extensions/context_extension.dart';
import 'package:taski_to_do/data/local/repositories/local_task_repository.dart';
import 'package:taski_to_do/modules/home/widgets/create_widget.dart';

part 'home_store.g.dart';

class HomeStore = HomePageBase with _$HomeStore;

abstract class HomePageBase with Store {
  final LocalTaskRepository _repository;

  HomePageBase(this._repository);

  final searchCtrl = TextEditingController();

  late BuildContext _context;

  @observable
  int btmNavBarIndex = 0;
  @observable
  ObservableList<TaskEntity> todoList = ObservableList.of([]);
  @observable
  ObservableList<TaskEntity> searchList = ObservableList.of([]);
  @observable
  ObservableList<TaskEntity> doneList = ObservableList.of([]);

  @computed
  String get tasksTodo => todoList.isEmpty ? 'Create tasks to achieve more.' : 'You’ve got ${todoList.length} tasks to do.';
  String get username => 'John';

  set buildContext(BuildContext value) => _context = value;

  Future<void> init() async {
    final result = await _repository.getTasks();
    result.fold((l) {
      if (_context.mounted) _context.showFailureSnackBar(l);
    }, (r) {
      searchList.addAll(r);
      todoList.addAll(r.where((e) => !e.isDone));
      doneList.addAll(r.where((e) => e.isDone));
    });
  }

  void onTapBtmNavBar(int value) {
    btmNavBarIndex = value;
    switch (value) {
      case 0:
        Modular.to.navigate('/todo', arguments: todoList);
      case 1:
        createTask();
      case 2:
        Modular.to.navigate('/search');
      case 3:
        Modular.to.navigate('/done');
      case _:
        Modular.to.navigate('/todo');
    }
  }

  @action
  void createTask() => _context.showBottomSheet((_) => CreateWidget(onCreateTask));

  @action
  void onSearch(String value) => searchList = todoList.where((e) => e.title.toLowerCase().contains(value.toLowerCase())).toList().asObservable();

  @action
  Future<void> onDeleteAll() async {
    final result = await _repository.deleteAllTask(doneList);
    result.fold((l) {
      if (_context.mounted) _context.showFailureSnackBar(l);
    }, (r) {
      doneList.clear();
      searchList.removeWhere((e) => e.isDone);
    });
  }

  @action
  Future<void> onChangeTask(TaskEntity value) async {
    final result = await _repository.putTask(value);
    result.fold((l) {
      if (_context.mounted) _context.showFailureSnackBar(l);
    }, (r) {
      if (value.isDone) {
        todoList.removeWhere((e) => e.id == value.id);
        doneList.add(value);
        final i = searchList.indexWhere((e) => e.id == value.id);
        searchList[i] = value;
      } else {
        doneList.removeWhere((e) => e.id == value.id);
        todoList.add(value);
        final i = searchList.indexWhere((e) => e.id == value.id);
        searchList[i] = value;
      }
    });
  }

  @action
  Future<void> onDeleteTask(TaskEntity value) async {
    final result = await _repository.putTask(value);
    result.fold((l) {
      if (_context.mounted) _context.showFailureSnackBar(l);
    }, (r) {
      doneList.remove(value);
      searchList.remove(value);
    });
  }

  @action
  Future<void> onCreateTask(TaskEntity value) async {
    final result = await _repository.putTask(value);
    result.fold((l) {
      if (_context.mounted) _context.showFailureSnackBar(l);
    }, (r) {
      todoList.add(value);
      searchList.add(value);
    });
  }
}
