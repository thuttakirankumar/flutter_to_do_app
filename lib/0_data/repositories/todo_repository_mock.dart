import 'package:either_dart/src/either.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/entities/todo_entry.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';
import 'package:flutter_to_do_app/1_domain/failures/failures.dart';
import 'package:flutter_to_do_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<TodoEntry> toDoEntries = List.generate(
    100,
    (index) => TodoEntry(
      id: EntryId.fromString(index.toString()),
      description: 'Description for Todo Entry $index',
      isCompleted: false,
    ),
  );

  final toDoCollections = List.generate(
    10,
    (index) => TodoCollection(
      id: CollectionId.fromString('$index'),
      title: 'Collection $index',
      color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
    ),
  );

  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
        Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntries(
    CollectionId collectionId,
  ) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      int endIndex = startIndex + 10;
      if (toDoEntries.length < endIndex) {
        endIndex = toDoEntries.length;
      }
      List<EntryId> entries = [];

      if (startIndex < toDoEntries.length) {
        entries = toDoEntries
            .sublist(startIndex, endIndex)
            .map((e) => e.id)
            .toList();
      }
      return Future.delayed(Duration(milliseconds: 200), () => Right(entries));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  ) {
    try {
      final entry = toDoEntries.firstWhere((e) => e.id == entryId);
      return Future.delayed(Duration(milliseconds: 200), () => Right(entry));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> upadteToDoEntry(
    CollectionId collectionId,
    EntryId entryId,
  ) {
    final index = toDoEntries.indexWhere((e) => e.id == entryId);
    final entryToUpdate = toDoEntries[index];
    final updateEntry = entryToUpdate.copyWith(
      isCompleted: !entryToUpdate.isCompleted,
    );
    toDoEntries[index] = updateEntry;
    return Future.delayed(
      Duration(milliseconds: 200),
      () => Right(updateEntry),
    );
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection(
    TodoCollection todoCollection,
  ) {
    final collectionToAdd = TodoCollection(
      id: CollectionId.fromString(toDoCollections.length.toString()),
      title: todoCollection.title,
      color: todoCollection.color,
    );
    toDoCollections.add(collectionToAdd);
    return Future.delayed(Duration(milliseconds: 200), () => Right(true));
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(TodoEntry todoEntry, CollectionId collectionId) {
    toDoEntries.add(todoEntry);
    return Future.delayed(Duration(milliseconds: 200), () => Right(true));
  }
}
