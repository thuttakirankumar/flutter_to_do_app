import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:flutter_to_do_app/core/use_case.dart';

class LoadTodoEntriesForCollection implements UseCase<List<EntryId>, CollectionIdParam> {
  final TodoRepository repository;
  LoadTodoEntriesForCollection({required this.repository});

  @override
  Future<Either<Failure, List<EntryId>>> call(CollectionIdParam params) async{
    try {
      return await repository.readToDoEntries(params.collectionId).fold(
          (left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Future.value(Left(
        ServerFailure(stackTrace: e.toString()),
      ));
    }
  }
  

}