part of 'todo_overview_cubit.dart';

abstract class TodoOverviewCubitState extends Equatable {
  const TodoOverviewCubitState();
  @override
  List<Object?> get props => [];
}

class TodoOverviewCubitLoadingState extends TodoOverviewCubitState {}

class TodoOverviewCubitErrorState extends TodoOverviewCubitState {}

class TodoOverviewCubitLoadedState extends TodoOverviewCubitState {
  final List<TodoCollection> todoCollections;
  const TodoOverviewCubitLoadedState({required this.todoCollections});

  @override
  List<Object?> get props => [todoCollections];
}
