import 'package:flutter/material.dart';

class TodoEntryItemError extends StatelessWidget {
  const TodoEntryItemError({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.error, color: Theme.of(context).colorScheme.error,),
      title: const Text('Error loading todo entry.'),
    );
  }
}