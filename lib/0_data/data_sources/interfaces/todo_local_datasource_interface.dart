import 'package:flutter_to_do_app/0_data/models/todo_collection_model.dart';
import 'package:flutter_to_do_app/0_data/models/todo_entry_model.dart';

abstract class TodoLocalDataSourceInterface {
  Future<TodoEntryModel> getTodoEntry({
    required String collectionId,
    required String entryId,
  });

  Future<List<String>> getTodoEntryIds({
    required String collectionId,
  });

  Future<TodoCollectionModel> getTodoCollection({
    required String collectionId,
  });

  Future<List<String>> getTodoCollectionIds();

  Future<bool> createTodoCollection({
    required TodoCollectionModel todoCollection,
  });

  Future<bool> createTodoEntry({
    required String collectionId,
    required TodoEntryModel todoEntry,
  });

  Future<TodoEntryModel> updateTodoEntry({
    required String collectionId,
    required String entryId,
  });
}