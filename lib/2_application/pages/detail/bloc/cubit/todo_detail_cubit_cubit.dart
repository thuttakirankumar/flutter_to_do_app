import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_entries_for_collection.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

part 'todo_detail_cubit_state.dart';

class TodoDetailCubitCubit extends Cubit<TodoDetailCubitState> {
  final CollectionId collectionId;
  final LoadTodoEntriesForCollection loadTodoEntriesForCollection;
  TodoDetailCubitCubit({required this.collectionId, required this.loadTodoEntriesForCollection}) : super(TodoDetailCubitLoading());

  Future<void> readToDoEntries() async {
    emit(TodoDetailCubitLoading());
    try {
      final entriesFuture =  loadTodoEntriesForCollection.call(CollectionIdParam(collectionId: collectionId));
      final entries = await entriesFuture;
      if(entries.isLeft){
        emit(TodoDetailCubitError());
      } else {
        emit(TodoDetailCubitLoaded(entryIds: entries.right));
      }
    } catch (_) {
      emit(TodoDetailCubitError());
    }
  }
}
