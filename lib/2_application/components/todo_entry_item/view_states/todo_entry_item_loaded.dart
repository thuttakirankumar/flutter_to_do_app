import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';

class TodoEntryItemLoaded extends StatelessWidget {
  final TodoEntry entryItem;
  final Function(bool?) onChanged;
  const TodoEntryItemLoaded({super.key, required this.entryItem, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: entryItem.isCompleted,
      onChanged: onChanged,
      title: Text(entryItem.description),
    );
  }
}