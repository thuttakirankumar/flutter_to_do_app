
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/create_todo_collection.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_collection/cubit/create_todo_collection_page_cubit.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/overview_page.dart';
import 'package:go_router/go_router.dart';

class CreateTodoEntryPageExtra{
  final CollectionId collectionId;
  final TodoEntryItemCallback todoEntryItemCallback;
  CreateTodoEntryPageExtra({required this.collectionId, required this.todoEntryItemCallback});
}

class CreateTodoCollectionPageProvider extends StatelessWidget {
  final TodoCollectionItemCallback todoCollectionItemCallback;
  const CreateTodoCollectionPageProvider({super.key, required this.todoCollectionItemCallback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoCollectionPageCubit(
        createTodoCollection: CreateTodoCollection(
          repository: RepositoryProvider.of(context),
        )
      ),
      child: CreateTodoCollectionPage(todoCollectionItemCallback: todoCollectionItemCallback),
    );
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  final TodoCollectionItemCallback todoCollectionItemCallback;
  const CreateTodoCollectionPage({super.key, required this.todoCollectionItemCallback});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
  
  );

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                context.read<CreateTodoCollectionPageCubit>().titleChanged(
                  value,
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Color'),
              onChanged: (value) {
                context.read<CreateTodoCollectionPageCubit>().colorChanged(
                  value,
                );
              },
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > TodoColor.predefinedColors.length) {
                    return 'Please enter a valid color index (0-${TodoColor.predefinedColors.length - 1})';
                  }
                } else {
                  return 'Please enter a color index';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  context.read<CreateTodoCollectionPageCubit>().submit();
                  widget.todoCollectionItemCallback();
                  context.pop();
                }
              },
              child: const Text('Create Collection'),
            ),
          ],
        ),
      ),
    );
  }
}
