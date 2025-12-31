import 'package:equatable/equatable.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';

class TodoEntry  extends Equatable{
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

  TodoEntry copyWith({
    EntryId? id,
    String? description,
    bool? isCompleted,
  }) {
    return TodoEntry(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  
  @override
  List<Object?> get props => [id, description, isCompleted];

 
}