import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {
}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ToDoEntryIdParams extends Params {
  final CollectionId collectionId;
  final EntryId entryId;

  ToDoEntryIdParams({required this.collectionId, required this.entryId});

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParam extends Params {
  final CollectionId collectionId;

  CollectionIdParam({required this.collectionId});

  @override
  List<Object?> get props => [collectionId];
}

class TodoCollectionParams extends Params {
  final TodoCollection todoCollection;

  TodoCollectionParams({required this.todoCollection});
  @override
  List<Object?> get props => [todoCollection];
}

class TodoEntryParams extends Params {
  final TodoEntry todoEntry;

  TodoEntryParams({required this.todoEntry});
  @override
  List<Object?> get props => [todoEntry];
}

 