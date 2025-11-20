import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections();
}