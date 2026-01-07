import 'package:flutter/cupertino.dart';
import 'package:flutter_to_do_app/0_data/data_sources/interfaces/todo_local_datasource_interface.dart';
import 'package:flutter_to_do_app/0_data/exceptions/exceptions.dart';
import 'package:flutter_to_do_app/0_data/models/todo_collection_model.dart';
import 'package:flutter_to_do_app/0_data/models/todo_entry_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class HiveLocalDatasource implements TodoLocalDataSourceInterface {
  late BoxCollection todoBoxCollection;

  bool isInitialized = false;

  Future<void> initialize() async {
    if (!isInitialized) {
      final directory = await getApplicationDocumentsDirectory();
      final hivePath = path.join(directory.path, 'hive');
      todoBoxCollection = await BoxCollection.open('todo_boxes', {
        'collection',
        'entry',
      }, path: hivePath);
      isInitialized = true;
    } else {
      debugPrint('HiveLocalDatasource is already initialized.');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    //await initialize();
    return todoBoxCollection.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    //await initialize();
    return todoBoxCollection.openBox<Map>('entry');
  }

  @override
  Future<bool> createTodoCollection({
    required TodoCollectionModel todoCollection,
  }) async {
    try {
      final collectionBox = await _openCollectionBox();
      final entryBox = await _openEntryBox();
      await collectionBox.put(todoCollection.id, todoCollection.toJson());
      await entryBox.put(todoCollection.id, {});
      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createTodoEntry({
    required String collectionId,
    required TodoEntryModel todoEntry,
  }) async {
    try {
      final entryBox = await _openEntryBox();
      final entriesMap = await entryBox.get(collectionId);
      if (entriesMap == null) {
        throw CollectionNotFoundException();
      }
      entriesMap.cast<String, dynamic>().putIfAbsent(
        todoEntry.id,
        () => todoEntry.toJson(),
      );
      await entryBox.put(collectionId, entriesMap);
      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoCollectionModel> getTodoCollection({
    required String collectionId,
  }) async {
    try {
      final collectionBox = await _openCollectionBox();
      final collectionMap =
         ( await collectionBox.get(collectionId))?.cast<String, dynamic>();
      if (collectionMap == null) {
        throw CollectionNotFoundException();
      }
      return Future.value(TodoCollectionModel.fromJson(collectionMap));
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoCollectionIds() async {
    try {
      final collectionBox = await _openCollectionBox();
      final collectionIds = await collectionBox.getAllKeys();
      return Future.value(collectionIds);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> getTodoEntry({
    required String collectionId,
    required String entryId,
  }) async {
    try {
      final entryBox = await _openEntryBox();
      final entriesMap = await entryBox.get(collectionId);
      if (entriesMap == null) {
        throw CollectionNotFoundException();
      }
      if (!entriesMap.containsKey(entryId)) {
        throw EntryNotFoundException();
      }
      final entry = entriesMap[entryId].cast<String, dynamic>();
      return Future.value(TodoEntryModel.fromJson(entry));
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entriesMap = await entryBox.get(collectionId);
      if (entriesMap == null) {
        throw CollectionNotFoundException();
      }
      final entryIds = entriesMap.cast<String, dynamic>().keys.toList();
      return Future.value(entryIds);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<TodoEntryModel> updateTodoEntry({
    required String collectionId,
    required String entryId,
  }) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) {
        throw CollectionNotFoundException();
      }
      if (!entryList.containsKey(entryId)) {
        throw EntryNotFoundException();
      }
      final entry = entryList[entryId].cast<String, dynamic>();

      final updatedEntry = TodoEntryModel(
        id: entry['id'],
        description: entry['description'],
        isCompleted: !entry['isCompleted'],
      );
      entryList[entryId] = updatedEntry.toJson();
      await entryBox.put(collectionId, entryList);
      return Future.value(updatedEntry);
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
