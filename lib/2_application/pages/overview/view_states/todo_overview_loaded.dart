import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:go_router/go_router.dart';

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
            onTap: () {
             
               context.goNamed(TodoDetailPage.pageConfig.name,
                pathParameters: {'collectionId': collection.id.value});
            
            },
            leading: Icon(Icons.check_circle_outline, color: collection.color.color),
            title: Text(collection.title),
          ),
        );
      },
    );
  }
}