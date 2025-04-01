// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomePageBase, Store {
  Computed<List<TaskEntity>>? _$searchListComputed;

  @override
  List<TaskEntity> get searchList => (_$searchListComputed ??=
          Computed<List<TaskEntity>>(() => super.searchList,
              name: 'HomePageBase.searchList'))
      .value;
  Computed<List<TaskEntity>>? _$doneListComputed;

  @override
  List<TaskEntity> get doneList =>
      (_$doneListComputed ??= Computed<List<TaskEntity>>(() => super.doneList,
              name: 'HomePageBase.doneList'))
          .value;
  Computed<List<TaskEntity>>? _$todoListComputed;

  @override
  List<TaskEntity> get todoList =>
      (_$todoListComputed ??= Computed<List<TaskEntity>>(() => super.todoList,
              name: 'HomePageBase.todoList'))
          .value;
  Computed<String>? _$tasksTodoComputed;

  @override
  String get tasksTodo =>
      (_$tasksTodoComputed ??= Computed<String>(() => super.tasksTodo,
              name: 'HomePageBase.tasksTodo'))
          .value;

  late final _$searchQueryAtom =
      Atom(name: 'HomePageBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'HomePageBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$taskListAtom =
      Atom(name: 'HomePageBase.taskList', context: context);

  @override
  ObservableList<TaskEntity> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(ObservableList<TaskEntity> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  late final _$onDeleteDoneTasksAsyncAction =
      AsyncAction('HomePageBase.onDeleteDoneTasks', context: context);

  @override
  Future<ResultDart<Unit, Exception>> onDeleteDoneTasks() {
    return _$onDeleteDoneTasksAsyncAction.run(() => super.onDeleteDoneTasks());
  }

  late final _$onChangeTaskAsyncAction =
      AsyncAction('HomePageBase.onChangeTask', context: context);

  @override
  Future<ResultDart<TaskEntity, Exception>> onChangeTask(TaskEntity task) {
    return _$onChangeTaskAsyncAction.run(() => super.onChangeTask(task));
  }

  late final _$onDeleteTaskAsyncAction =
      AsyncAction('HomePageBase.onDeleteTask', context: context);

  @override
  Future<ResultDart<Unit, Exception>> onDeleteTask(TaskEntity task) {
    return _$onDeleteTaskAsyncAction.run(() => super.onDeleteTask(task));
  }

  late final _$onCreateTaskAsyncAction =
      AsyncAction('HomePageBase.onCreateTask', context: context);

  @override
  Future<ResultDart<TaskEntity, Exception>> onCreateTask(TaskEntity task) {
    return _$onCreateTaskAsyncAction.run(() => super.onCreateTask(task));
  }

  late final _$HomePageBaseActionController =
      ActionController(name: 'HomePageBase', context: context);

  @override
  void setCurrentIndex(int index) {
    final _$actionInfo = _$HomePageBaseActionController.startAction(
        name: 'HomePageBase.setCurrentIndex');
    try {
      return super.setCurrentIndex(index);
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
searchQuery: ${searchQuery},
currentIndex: ${currentIndex},
taskList: ${taskList},
searchList: ${searchList},
doneList: ${doneList},
todoList: ${todoList},
tasksTodo: ${tasksTodo}
    ''';
  }
}
