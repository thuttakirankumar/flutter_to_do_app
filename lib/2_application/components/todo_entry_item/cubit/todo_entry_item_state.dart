part of 'todo_entry_item_cubit.dart';

abstract class TodoEntryItemState extends Equatable {
  const TodoEntryItemState();

  @override
  List<Object> get props => [];
}

class TodoEntryItemLoadingState extends TodoEntryItemState {}

class TodoEntryItemErrorState extends TodoEntryItemState {}

class TodoEntryItemLoadedState extends TodoEntryItemState {
  final TodoEntry todoEntry;

  const TodoEntryItemLoadedState({required this.todoEntry});

  @override
  List<Object> get props => [todoEntry];
}
