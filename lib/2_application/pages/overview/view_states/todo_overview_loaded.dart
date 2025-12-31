import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:flutter_to_do_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
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
        return BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
          buildWhen: (previous, current) => previous.selectedCollectionId != current.selectedCollectionId,
          builder: (context, state) {
            debugPrint('build item collection: ${collection.id.value}');
            return ListTile(
              tileColor: colorScheme.surface,
              selectedTileColor: colorScheme.surfaceContainerHighest,
              iconColor: collection.color.color,
              selectedColor: collection.color.color,
              selected: state.selectedCollectionId == collection.id,
              onTap: () {
                context
                    .read<NavigationTodoCubit>()
                    .selectedTodoCollectionChanged(collection.id);

                if (Breakpoints.small.isActive(context)) {
                  context.goNamed(
                    TodoDetailPage.pageConfig.name,
                    pathParameters: {'collectionId': collection.id.value},
                  );
                }
              },
              leading: Icon(
                Icons.check_circle_outline,
                color: collection.color.color,
              ),
              title: Text(collection.title),
            );
          },
        );
      },
    );
  }
}
