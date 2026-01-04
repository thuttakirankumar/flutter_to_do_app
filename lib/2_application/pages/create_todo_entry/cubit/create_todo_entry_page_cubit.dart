import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/usecases/create_todo_entry.dart';
import 'package:flutter_to_do_app/2_application/core/form_value.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

part 'create_todo_entry_page_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  final CollectionId collectionId;
  final CreateTodoEntry createTodoEntry;
  CreateTodoEntryPageCubit({required this.collectionId, required this.createTodoEntry}) : super(CreateTodoEntryPageState());

  void descriptionChanged(String? description) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    // could do more complex validation here
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }

    emit(state.copywith(
      description: FormValue(
        value: description,
        validationStatus: currentStatus,
      ),
    ));

  }

  void submit() async {
    final todoEntry = TodoEntry.empty().copyWith(
      description: state.description?.value ?? '',
    );

    await createTodoEntry.call(TodoEntryParams(
      todoEntry: todoEntry,
    ));

  }


}
