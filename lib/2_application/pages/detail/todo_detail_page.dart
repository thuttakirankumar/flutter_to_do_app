import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_entries_for_collection.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/bloc/cubit/todo_detail_cubit_cubit.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/view_states/todo_detail_error.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/view_states/todo_detail_loaded.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/view_states/todo_detail_loading.dart';

typedef TodoEntryItemCallback = Function();

class TodoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;

  const TodoDetailPageProvider({super.key, required this.collectionId,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoDetailCubitCubit(
        collectionId: collectionId,
        loadTodoEntriesForCollection: LoadTodoEntriesForCollection(repository: RepositoryProvider.of(context)),
      )..readToDoEntries(),
      child: TodoDetailPage(collectionId: collectionId),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  final CollectionId collectionId;

  const TodoDetailPage({super.key, required this.collectionId,});

  static const pageConfig = PageConfig(
    icon: Icons.details_rounded,
    name: 'todo_detail',
    child: Placeholder()
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailCubitCubit, TodoDetailCubitState>(
      builder: (context, state) {
        if (state is TodoDetailCubitLoading) {
          return TodoDetailLoading();
        } else if (state is TodoDetailCubitError) {
          return TodoDetailError();
        } else if (state is TodoDetailCubitLoaded) {
          return TodoDetailLoaded(
            entryIds: state.entryIds,
            collectionId: collectionId, todoEntryItemCallback: () {  
              context.read<TodoDetailCubitCubit>().readToDoEntries();
            },
            
          );
        }
        return const Placeholder();
      },
    );
  }
}