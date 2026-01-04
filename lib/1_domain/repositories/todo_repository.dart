import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections();

  Future<Either<Failure,TodoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, List<EntryId>>> readToDoEntries(CollectionId collectionId);

  Future<Either<Failure,TodoEntry>> upadteToDoEntry(
      CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, bool>> createToDoCollection(TodoCollection todoCollection);

  Future<Either<Failure, bool>> createTodoEntry(TodoEntry todoEntry);
}