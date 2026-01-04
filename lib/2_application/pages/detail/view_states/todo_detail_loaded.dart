import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/todo_entry_item.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:go_router/go_router.dart';

class TodoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;
  final TodoEntryItemCallback todoEntryItemCallback;
  const TodoDetailLoaded({super.key, required this.entryIds, required this.collectionId, required this.todoEntryItemCallback});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) {
                return TodoEntryItemProvider(
                  entryId: entryIds[index],
                  collectionId: collectionId,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                   context.pushNamed(
                      CreateTodoEntryPage.pageConfig.name,
                      extra: CreateTodoEntryPageExtra(collectionId: collectionId, todoEntryItemCallback: todoEntryItemCallback),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}