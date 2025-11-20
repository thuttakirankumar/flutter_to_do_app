import 'package:either_dart/src/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() {
    final list = List.generate(
      10,
      (index) => TodoCollection(
        id: CollectionId.fromString('collection_$index'),
        title: 'Collection $index',
        color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
      ),
    );
    return Future.delayed(Duration(milliseconds: 200), () => Right(list));
  }
  
}