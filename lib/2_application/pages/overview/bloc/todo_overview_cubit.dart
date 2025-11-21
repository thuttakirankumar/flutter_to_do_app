import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_collections.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

part 'todo_overview_cubit_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewCubitState> {
  final LoadTodoCollections loadTodoCollections;
  TodoOverviewCubit({
    required this.loadTodoCollections,
    TodoOverviewCubitState? initialState,
  }) : super(initialState ?? TodoOverviewCubitLoadingState());

  Future<void> readToDoCollections() async {
    emit(TodoOverviewCubitLoadingState());
    try {
      final collectionsFuture =  loadTodoCollections.call(NoParams());
      final collections = await collectionsFuture;
      if(collections.isLeft){
        emit(TodoOverviewCubitErrorState());
      } else {
        emit(TodoOverviewCubitLoadedState(todoCollections: collections.right));
      }
    } catch (_) {
      emit(TodoOverviewCubitErrorState());
    }
  }
}