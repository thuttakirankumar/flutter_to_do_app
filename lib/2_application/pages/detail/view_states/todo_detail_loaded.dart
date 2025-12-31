import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/2_application/components/todo_entry_item/todo_entry_item.dart';

class TodoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;
  const TodoDetailLoaded({super.key, required this.entryIds, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: entryIds.length,
          itemBuilder: (context, index) {
            return TodoEntryItemProvider(
              entryId: entryIds[index],
              collectionId: collectionId,
            );
          },
        ),
      ),
    );
  }
}