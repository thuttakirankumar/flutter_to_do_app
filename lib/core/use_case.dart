import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
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