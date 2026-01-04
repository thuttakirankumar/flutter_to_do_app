import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/usecases/load_todo_collections.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';

typedef TodoCollectionItemCallback = Function();

class TodoOverviewPageProvider extends StatelessWidget {
  const TodoOverviewPageProvider({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverviewCubit(
        loadTodoCollections: LoadTodoCollections(repository: RepositoryProvider.of(context)),
      )..readToDoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    name: 'overview',
    child: TodoOverviewPageProvider(),
  );

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.tealAccent,
      child: BlocBuilder<TodoOverviewCubit, TodoOverviewCubitState>(
        builder: (context, state) {
          if (state is TodoOverviewCubitLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoOverviewCubitErrorState) {
            return const Center(child: Text('Error loading todo collections'));
          } else if (state is TodoOverviewCubitLoadedState) {
            return TodoOverviewLoaded(
              collections: state.todoCollections, todoCollectionItemCallback: () => context.read<TodoOverviewCubit>().readToDoCollections(),
        
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
