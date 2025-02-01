// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomePageBase, Store {
  Computed<String>? _$tasksTodoComputed;

  @override
  String get tasksTodo =>
      (_$tasksTodoComputed ??= Computed<String>(() => super.tasksTodo,
              name: 'HomePageBase.tasksTodo'))
          .value;

  late final _$btmNavBarIndexAtom =
      Atom(name: 'HomePageBase.btmNavBarIndex', context: context);

  @override
  int get btmNavBarIndex {
    _$btmNavBarIndexAtom.reportRead();
    return super.btmNavBarIndex;
  }

  @override
  set btmNavBarIndex(int value) {
    _$btmNavBarIndexAtom.reportWrite(value, super.btmNavBarIndex, () {
      super.btmNavBarIndex = value;
    });
  }

  late final _$todoListAtom =
      Atom(name: 'HomePageBase.todoList', context: context);

  @override
  ObservableList<TaskEntity> get todoList {
    _$todoListAtom.reportRead();
    return super.todoList;
  }

  @override
  set todoList(ObservableList<TaskEntity> value) {
    _$todoListAtom.reportWrite(value, super.todoList, () {
      super.todoList = value;
    });
  }

  late final _$searchListAtom =
      Atom(name: 'HomePageBase.searchList', context: context);

  @override
  ObservableList<TaskEntity> get searchList {
    _$searchListAtom.reportRead();
    return super.searchList;
  }

  @override
  set searchList(ObservableList<TaskEntity> value) {
    _$searchListAtom.reportWrite(value, super.searchList, () {
      super.searchList = value;
    });
  }

  late final _$doneListAtom =
      Atom(name: 'HomePageBase.doneList', context: context);

  @override
  ObservableList<TaskEntity> get doneList {
    _$doneListAtom.reportRead();
    return super.doneList;
  }

  @override
  set doneList(ObservableList<TaskEntity> value) {
    _$doneListAtom.reportWrite(value, super.doneList, () {
      super.doneList = value;
    });
  }

  late final _$onDeleteAllAsyncAction =
      AsyncAction('HomePageBase.onDeleteAll', context: context);

  @override
  Future<void> onDeleteAll() {
    return _$onDeleteAllAsyncAction.run(() => super.onDeleteAll());
  }

  late final _$onChangeTaskAsyncAction =
      AsyncAction('HomePageBase.onChangeTask', context: context);

  @override
  Future<void> onChangeTask(TaskEntity value) {
    return _$onChangeTaskAsyncAction.run(() => super.onChangeTask(value));
  }

  late final _$onDeleteTaskAsyncAction =
      AsyncAction('HomePageBase.onDeleteTask', context: context);

  @override
  Future<void> onDeleteTask(TaskEntity value) {
    return _$onDeleteTaskAsyncAction.run(() => super.onDeleteTask(value));
  }

  late final _$onCreateTaskAsyncAction =
      AsyncAction('HomePageBase.onCreateTask', context: context);

  @override
  Future<void> onCreateTask(TaskEntity value) {
    return _$onCreateTaskAsyncAction.run(() => super.onCreateTask(value));
  }

  late final _$HomePageBaseActionController =
      ActionController(name: 'HomePageBase', context: context);

  @override
  void createTask() {
    final _$actionInfo = _$HomePageBaseActionController.startAction(
        name: 'HomePageBase.createTask');
    try {
      return super.createTask();
    } finally {
      _$HomePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSearch(String value) {
    final _$actionInfo = _$HomePageBaseActionController.startAction(
        name: 'HomePageBase.onSearch');
    try {
      return super.onSearch(value);
    } finally {
      _$HomePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
btmNavBarIndex: ${btmNavBarIndex},
todoList: ${todoList},
searchList: ${searchList},
doneList: ${doneList},
tasksTodo: ${tasksTodo}
    ''';
  }
}
