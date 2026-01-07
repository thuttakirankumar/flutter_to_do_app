import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:flutter_to_do_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/overview_page.dart';
import 'package:go_router/go_router.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<TodoCollection> collections;
  final TodoCollectionItemCallback todoCollectionItemCallback;
  const TodoOverviewLoaded({super.key, required this.collections, required this.todoCollectionItemCallback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
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
                      context.pushNamed(
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
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () async {
                context.pushNamed(CreateTodoCollectionPage.pageConfig.name, extra: todoCollectionItemCallback);
              // if(result == true){
              //   todoCollectionItemCallback();
              //   }


              },
              child:  Icon(CreateTodoCollectionPage.pageConfig.icon),
            ),
          ),
        )
      ],
    );
  }
}
