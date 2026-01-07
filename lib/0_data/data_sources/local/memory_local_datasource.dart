import 'package:flutter_to_do_app/0_data/data_sources/interfaces/todo_local_datasource_interface.dart';
import 'package:flutter_to_do_app/0_data/exceptions/exceptions.dart';
import 'package:flutter_to_do_app/0_data/models/todo_collection_model.dart';
import 'package:flutter_to_do_app/0_data/models/todo_entry_model.dart';

class MemoryLocalDatasource implements TodoLocalDataSourceInterface {
  final List<TodoCollectionModel> toDoCollections = [];
  final Map<String, List<TodoEntryModel>> toDoEntries = {};


  @override
  Future<bool> createTodoCollection({required TodoCollectionModel todoCollection}) {
  try {
      toDoCollections.add(todoCollection);
      toDoEntries.putIfAbsent(todoCollection.id, () => []);
      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createTodoEntry({required String collectionId, required TodoEntryModel todoEntry}) {
   try {
      final doesCollectionExist = toDoEntries.containsKey(collectionId);
      if(doesCollectionExist) {
        toDoEntries[collectionId]?.add(todoEntry);
        return Future.value(true);
      } else {
       throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoCollectionModel> getTodoCollection({required String collectionId}) {
    try {
      final collection = toDoCollections.firstWhere((c) => c.id == collectionId, orElse: () {
        throw CollectionNotFoundException();
      });
      return Future.value(collection);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoCollectionIds() {
    try {
      final collectionIds = toDoCollections.map((c) => c.id).toList();
      return Future.value(collectionIds);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> getTodoEntry({required String collectionId, required String entryId}) {
   try {
      final entries = toDoEntries[collectionId];
      if (entries == null) {
        throw EntryNotFoundException();
      }
      final entry = entries.firstWhere((e) => e.id == entryId, orElse: () {
        throw EntryNotFoundException();
      });
      return Future.value(entry);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) {
    try {
      final entries = toDoEntries[collectionId];
      if (entries == null) {
        throw EntryNotFoundException();
      }
      final entryIds = entries.map((e) => e.id).toList();
      return Future.value(entryIds);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> updateTodoEntry({required String collectionId, required String entryId}) {
   try {
      final entries = toDoEntries[collectionId];
      if (entries == null) {
        throw EntryNotFoundException();
      }
      final index = entries.indexWhere((e) => e.id == entryId);
      if (index == -1) {
        throw EntryNotFoundException();
      }
      final entryToUpdate = entries[index];
      final updatedEntry = TodoEntryModel(
        id: entryToUpdate.id,
        description: entryToUpdate.description,
        isCompleted: !entryToUpdate.isCompleted,
      );
      entries[index] = updatedEntry;
      return Future.value(updatedEntry);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

}