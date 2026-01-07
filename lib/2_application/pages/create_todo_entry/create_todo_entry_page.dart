import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/usecases/create_todo_entry.dart';
import 'package:flutter_to_do_app/2_application/core/form_value.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_entry/cubit/create_todo_entry_page_cubit.dart';
import 'package:go_router/go_router.dart';

class CreateToDoEntryPageProvider extends StatelessWidget {
  final CreateTodoEntryPageExtra createTodoEntryPageExtra;
  const CreateToDoEntryPageProvider({super.key, required this.createTodoEntryPageExtra});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoEntryPageCubit(
        collectionId: createTodoEntryPageExtra.collectionId,
        createTodoEntry: CreateTodoEntry(
          repository: RepositoryProvider.of(context), 
        ),
      ),
      child: CreateTodoEntryPage(createTodoEntryPageExtra: createTodoEntryPageExtra),
      );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  final CreateTodoEntryPageExtra createTodoEntryPageExtra;
  const CreateTodoEntryPage({super.key, required this.createTodoEntryPageExtra});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_entry',
  );

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
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
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                context.read<CreateTodoEntryPageCubit>().descriptionChanged(
                  value,
                );
              },
              validator: (value) {
                final currentValidationState =
                    context
                        .read<CreateTodoEntryPageCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.pending;
                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'Please enter a valid description needing at least 2 characters';
                  case ValidationStatus.pending:
                  case ValidationStatus.success:
                    return null;
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  context.read<CreateTodoEntryPageCubit>().submit().then((_) {
                    widget.createTodoEntryPageExtra.todoEntryItemCallback();
                  });
                  context.pop();
                }
               
              },
              child: const Text('Create To-Do Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
