// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomePageBase, Store {
  Computed<List<TaskEntity>>? _$filteredTasksComputed;

  @override
  List<TaskEntity> get filteredTasks => (_$filteredTasksComputed ??=
          Computed<List<TaskEntity>>(() => super.filteredTasks, name: 'HomePageBase.filteredTasks'))
      .value;
  Computed<List<TaskEntity>>? _$doneTasksComputed;

  @override
  List<TaskEntity> get doneTasks =>
      (_$doneTasksComputed ??= Computed<List<TaskEntity>>(() => super.doneTasks, name: 'HomePageBase.doneTasks')).value;
  Computed<List<TaskEntity>>? _$todoTasksComputed;

  @override
  List<TaskEntity> get todoTasks =>
      (_$todoTasksComputed ??= Computed<List<TaskEntity>>(() => super.todoTasks, name: 'HomePageBase.todoTasks')).value;

  late final _$isLoadingAtom = Atom(name: 'HomePageBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(name: 'HomePageBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchQueryAtom = Atom(name: 'HomePageBase.searchQuery', context: context);

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

  late final _$currentIndexAtom = Atom(name: 'HomePageBase.currentIndex', context: context);

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

  late final _$allTasksAtom = Atom(name: 'HomePageBase.allTasks', context: context);

  @override
  ObservableList<TaskEntity> get allTasks {
    _$allTasksAtom.reportRead();
    return super.allTasks;
  }

  @override
  set allTasks(ObservableList<TaskEntity> value) {
    _$allTasksAtom.reportWrite(value, super.allTasks, () {
      super.allTasks = value;
    });
  }

  late final _$deleteAllTasksAsyncAction = AsyncAction('HomePageBase.deleteAllTasks', context: context);

  @override
  Future<void> deleteAllTasks(List<TaskEntity> tasks) {
    return _$deleteAllTasksAsyncAction.run(() => super.deleteAllTasks(tasks));
  }

  late final _$updateTaskAsyncAction = AsyncAction('HomePageBase.updateTask', context: context);

  @override
  Future<void> updateTask(TaskEntity task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  late final _$deleteTaskAsyncAction = AsyncAction('HomePageBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(TaskEntity task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  late final _$createTaskAsyncAction = AsyncAction('HomePageBase.createTask', context: context);

  @override
  Future<void> createTask(TaskEntity task) {
    return _$createTaskAsyncAction.run(() => super.createTask(task));
  }

  late final _$HomePageBaseActionController = ActionController(name: 'HomePageBase', context: context);

  @override
  void setCurrentIndex(int index) {
    final _$actionInfo = _$HomePageBaseActionController.startAction(name: 'HomePageBase.setCurrentIndex');
    try {
      return super.setCurrentIndex(index);
    } finally {
      _$HomePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchTasks(String value) {
    final _$actionInfo = _$HomePageBaseActionController.startAction(name: 'HomePageBase.searchTasks');
    try {
      return super.searchTasks(value);
    } finally {
      _$HomePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
currentIndex: ${currentIndex},
allTasks: ${allTasks},
filteredTasks: ${filteredTasks},
doneTasks: ${doneTasks},
todoTasks: ${todoTasks}
    ''';
  }
}
