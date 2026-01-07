import 'package:either_dart/either.dart';
import 'package:flutter_to_do_app/0_data/data_sources/interfaces/todo_local_datasource_interface.dart';
import 'package:flutter_to_do_app/0_data/exceptions/exceptions.dart';
import 'package:flutter_to_do_app/0_data/models/todo_collection_model.dart';
import 'package:flutter_to_do_app/0_data/models/todo_entry_model.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryLocal implements TodoRepository {

  final TodoLocalDataSourceInterface localDataSource;

  TodoRepositoryLocal({required this.localDataSource});
  @override
  Future<Either<Failure, bool>> createToDoCollection(TodoCollection todoCollection) async{
    try{
      final result = await localDataSource.createTodoCollection(
        todoCollection: todoCollectionEntityToModel(todoCollection)
      );
      return Right(result);

    }on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(TodoEntry todoEntry, CollectionId collectionId) async {
   try{
      final result = await localDataSource.createTodoEntry(
        collectionId: collectionId.value,
        todoEntry: todoEntryEntityToModel(todoEntry)
      );
      return Right(result);
    }on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() async{
  try{
    final collectionModels = await localDataSource.getTodoCollectionIds();
    final collections = collectionModels.map((id) async {
      final model = await localDataSource.getTodoCollection(collectionId: id);
      return todoCollectionModelToEntity(model);
    }).toList();

    final resolvedCollections = await Future.wait(collections);
    return Right(resolvedCollections);

  }on CacheException catch (e) {
    return Future.value(Left(CacheFailure(stackTrace: e.toString())));
  } on Exception catch (e) {
    return Future.value(Left(ServerFailure(stackTrace: e.toString())));
  }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntries(CollectionId collectionId)async {
    try{
      final entryIds = await localDataSource.getTodoEntryIds(
        collectionId: collectionId.value
      );
      final ids = entryIds.map((id) => EntryId.fromString(id)).toList();
      return Future.value(Right(ids));  
    }on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readToDoEntry(CollectionId collectionId, EntryId entryId) async{
   try{
      final model = await localDataSource.getTodoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value
      );
      final entity = todoEntryModelToEntity(model);
      return Right(entity);
    }on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> upadteToDoEntry(CollectionId collectionId, EntryId entryId) async{
    try{
      final model = await localDataSource.updateTodoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value
      );
      final entity = todoEntryModelToEntity(model);
      return Right(entity);
    }on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

   TodoCollection todoCollectionModelToEntity(TodoCollectionModel model) {
    return TodoCollection(
      id: CollectionId.fromString(model.id),
      title: model.title,
      color: TodoColor(colorIndex: model.colorIndex)
    );
  }

  TodoCollectionModel todoCollectionEntityToModel(TodoCollection entity) {
    return TodoCollectionModel(
      id: entity.id.value,
      title: entity.title,
      colorIndex: entity.color.colorIndex
    );
  }

  TodoEntry todoEntryModelToEntity(TodoEntryModel model) {
    return TodoEntry(
      id: EntryId.fromString(model.id),
      description: model.description,
      isCompleted: model.isCompleted,
    );
  }

  TodoEntryModel todoEntryEntityToModel(TodoEntry entity) {
    return TodoEntryModel(
      id: entity.id.value,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }
  

}