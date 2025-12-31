import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/usecases/update_todo_entry.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/cubit/todo_entry_item_cubit.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/view_states/todo_entry_item_loaded.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/view_states/todo_entry_item_loading.dart';

class TodoEntryItemProvider extends StatelessWidget {
  final EntryId entryId;
  final CollectionId collectionId;
  const TodoEntryItemProvider({super.key, required this.entryId, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoEntryItemCubit(
        entryId: entryId,
        collectionId: collectionId,
        loadTodoEntry: LoadTodoEntry(RepositoryProvider.of(context)), 
        updateTodoEntry: UpdateTodoEntry(repository: RepositoryProvider.of(context)),
      )..fetch(),
      child: const TodoEntryItem(),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
      builder: (context, state) {
        if (state is TodoEntryItemLoadingState) {
          return TodoEntryItemLoading();
        } else if (state is TodoEntryItemErrorState) {
          return TodoEntryItemError();
        } else if (state is TodoEntryItemLoadedState) {
          return TodoEntryItemLoaded(entryItem: state.todoEntry, onChanged: (_)=> context.read<TodoEntryItemCubit>().update(),);
        }
        return const Placeholder();
      },
    );
  }
}