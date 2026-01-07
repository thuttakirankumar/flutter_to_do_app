import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/0_data/data_sources/local/hive_local_datasource.dart';
import 'package:flutter_to_do_app/0_data/repositories/todo_repository_local.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/2_application/app/basic_app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final hiveDataSource = HiveLocalDatasource();
  await hiveDataSource.initialize();
  runApp(
    RepositoryProvider<TodoRepository>(
      create: (context) =>
          TodoRepositoryLocal(localDataSource: hiveDataSource),
      child: const BasicApp(),
    ),
  );
}
