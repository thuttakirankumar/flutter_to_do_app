import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<TodoCollection> collections;
  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
        return Card(
          child: ListTile(
            tileColor: colorScheme.surface,
            selectedTileColor: colorScheme.surfaceContainerHighest,
            iconColor: collection.color.color,
            selectedColor: collection.color.color,
            onTap: () => debugPrint('Tapped on ${collection.title}'),
            leading: Icon(Icons.check_circle_outline, color: collection.color.color),
            title: Text(collection.title),
          ),
        );
      },
    );
  }
}