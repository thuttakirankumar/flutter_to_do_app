import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/usecases/update_todo_entry.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

part 'todo_entry_item_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;
  final UpdateTodoEntry updateTodoEntry;
  TodoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadTodoEntry,
    required this.updateTodoEntry,
  }) : super(TodoEntryItemLoadingState());

  Future<void> fetch() async {
    emit(TodoEntryItemLoadingState());
    try {
      final todoEntry = await loadTodoEntry.call(
       ToDoEntryIdParams(collectionId: collectionId, entryId: entryId)
      );
      if (todoEntry.isLeft) {
        emit(TodoEntryItemErrorState());
      } else {
        emit(TodoEntryItemLoadedState(todoEntry: todoEntry.right));
      }
    } catch (e) {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
      try {
        final updatedEntry = await updateTodoEntry.call(
          ToDoEntryIdParams(collectionId: collectionId, entryId: entryId)
        );
        if (updatedEntry.isLeft) {
          emit(TodoEntryItemErrorState());
        } else {
          emit(TodoEntryItemLoadedState(todoEntry: updatedEntry.right));
        }
      } catch (e) {
        emit(TodoEntryItemErrorState());
      }
    
  }
}


