import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';

class TodoEntry {
  final EntryId id;
  final String description;
  final bool isCompleted;

  TodoEntry({
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  factory TodoEntry.empty() {
    return TodoEntry(
      id: EntryId(),
      description: '',
      isCompleted: false,
    );
  }

 
}