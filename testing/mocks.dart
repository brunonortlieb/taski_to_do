import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_to_do/data/datasources/task_datasource.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';
import 'package:taski_to_do/presentation/bloc/home_bloc.dart';
import 'package:taski_to_do/presentation/mobx/home_store.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockTaskDatasource extends Mock implements TaskDatasource {}

class MockBox<T> extends Mock implements Box<T> {}

class MockTaskRepository extends Mock implements TaskRepository {}

class MockHomeStore extends Mock implements HomeStore {}

class MockBuildContext extends Mock implements BuildContext {}

class MockHomeBloc extends Mock implements HomeBloc {}

class MockTaskLoadedState extends Mock implements TaskLoadedState {}

class MockCallback extends Mock {
  void call([dynamic _]);
}
