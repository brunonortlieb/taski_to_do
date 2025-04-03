import 'package:auto_injector/auto_injector.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski_to_do/data/datasources/local/task_local_datasoruce.dart';
import 'package:taski_to_do/data/datasources/task_datasource.dart';
import 'package:taski_to_do/data/repositories/task_repository_impl.dart';
import 'package:taski_to_do/domain/repositories/task_repository.dart';
import 'package:taski_to_do/presentation/bloc/blocs/home_bloc.dart';
import 'package:taski_to_do/presentation/tasks/controllers/home_store.dart';

final injector = AutoInjector();

void setupInjection() {
  injector.addInstance(Hive);
  injector.addSingleton<TaskDatasource>(TaskLocalDatasourceImpl.new);
  injector.addSingleton<TaskRepository>(TaskRepositoryImpl.new);
}

void mobxInjection() {
  setupInjection();
  injector.addSingleton(HomeStore.new);

  injector.commit();
}

void blocInjection() {
  setupInjection();
  injector.addSingleton(HomeBloc.new);

  injector.commit();
}
