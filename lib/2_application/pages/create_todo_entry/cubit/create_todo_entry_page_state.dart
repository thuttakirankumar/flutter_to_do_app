part of 'create_todo_entry_page_cubit.dart';
 class CreateTodoEntryPageState extends Equatable {
  final FormValue<String?>? description;

  const CreateTodoEntryPageState({
    this.description,
  });

 CreateTodoEntryPageState copywith({
    FormValue<String?>? description,
  }) {
    return CreateTodoEntryPageState(
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [description];
}

