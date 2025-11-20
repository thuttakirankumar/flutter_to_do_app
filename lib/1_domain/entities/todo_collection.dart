import 'package:flutter_to_do_app/1_domain/entities/todo_color.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';

class TodoCollection {
  final CollectionId id;
  final String title;
  final TodoColor color;

  const TodoCollection({
    required this.id,
    required this.title,
    required this.color,
  });

  factory TodoCollection.empty() {
    return TodoCollection(
      id: CollectionId(),
      title: '',
      color: const TodoColor(colorIndex: 0),
    );
  }

}