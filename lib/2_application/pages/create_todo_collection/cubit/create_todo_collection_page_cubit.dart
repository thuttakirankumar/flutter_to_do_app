import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/usecases/create_todo_collection.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit extends Cubit<CreateTodoCollectionPageState> {
  final CreateTodoCollection createTodoCollection;
  CreateTodoCollectionPageCubit({required this.createTodoCollection}) : super(CreateTodoCollectionPageState());


  void titleChanged(String title) {
    emit(state.copywith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copywith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '0') ?? 0;


    await createTodoCollection.call(TodoCollectionParams(
      todoCollection: TodoCollection.empty().copywith(
        title: state.title ?? '',
        color: TodoColor(
          colorIndex: parsedColorIndex,
        ),
      )
    ));
  }

}
