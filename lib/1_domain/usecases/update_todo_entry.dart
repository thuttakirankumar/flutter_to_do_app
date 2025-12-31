import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

class UpdateTodoEntry extends UseCase<TodoEntry, ToDoEntryIdParams> {
  final TodoRepository repository;

  UpdateTodoEntry({required this.repository});

  @override
  Future<Either<Failure, TodoEntry>> call(ToDoEntryIdParams params) async {
    try {
      final updatedEntry =  await repository.upadteToDoEntry(
          params.collectionId, params.entryId);
      return updatedEntry.fold(
          (left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Future.value(Left(
        ServerFailure(stackTrace: e.toString()),
      ));
    }
  }

}