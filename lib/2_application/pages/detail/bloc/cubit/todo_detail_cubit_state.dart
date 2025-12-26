part of 'todo_detail_cubit_cubit.dart';

abstract class TodoDetailCubitState extends Equatable {
  const TodoDetailCubitState();

  @override
  List<Object> get props => [];
}

class TodoDetailCubitLoading extends TodoDetailCubitState {}

class TodoDetailCubitError extends TodoDetailCubitState {}

class TodoDetailCubitLoaded extends TodoDetailCubitState {
  final List<EntryId> entryIds;
  const TodoDetailCubitLoaded({required this.entryIds});
  @override
  List<Object> get props => [entryIds];
}
