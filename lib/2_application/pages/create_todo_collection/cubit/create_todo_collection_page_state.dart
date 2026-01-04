part of 'create_todo_collection_page_cubit.dart';

 class CreateTodoCollectionPageState extends Equatable {
  final String? title;
  final String? color;

  const CreateTodoCollectionPageState({
    this.title,
    this.color,
  });

 CreateTodoCollectionPageState copywith({
    String? title,
    String? color,
  }) {
    return CreateTodoCollectionPageState(
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [title, color];
}


