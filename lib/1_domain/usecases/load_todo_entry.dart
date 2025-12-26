import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

class LoadTodoEntry implements UseCase<TodoEntry, ToDoEntryIdParams> {
  final TodoRepository repository;

  LoadTodoEntry(this.repository);

  @override
  Future<Either<Failure, TodoEntry>> call(ToDoEntryIdParams params) {
  try{
    final loadedEntry = repository.readToDoEntry(params.collectionId, params.entryId);
    return  loadedEntry.fold( (left)=> Left(left), (right)=> Right(right));
    } on Exception catch (e) {
      return Future.value(Left(
        ServerFailure(stackTrace: e.toString()),
        ));

  }
   
  }

}