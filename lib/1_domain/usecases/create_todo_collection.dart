import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

class CreateTodoCollection extends UseCase<bool, TodoCollectionParams> {
  final TodoRepository repository;

  CreateTodoCollection({required this.repository});

  @override
  Future<Either<Failure, bool>> call(TodoCollectionParams params) async {
    try {
      final result = await repository.createToDoCollection(
        params.todoCollection,
      );
      return result.fold(
        (failure) => Left(failure),
        (isCreated) => Right(isCreated),
      );
    } catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
