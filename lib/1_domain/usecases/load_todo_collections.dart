import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

class LoadTodoCollections  implements UseCase<List<TodoCollection>, NoParams>  {
  final TodoRepository repository;

  LoadTodoCollections({required this.repository});

  @override
  Future<Either<Failure, List<TodoCollection>>> call(NoParams params) async {
    try{
    return await repository.readToDoCollections().fold( (left)=> Left(left), (right)=> Right(right));
    } on Exception catch (e) {
      return Left(
        ServerFailure(stackTrace: e.toString()),
        );
    }

  }

}