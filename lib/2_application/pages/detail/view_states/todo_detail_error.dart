import 'package:flutter/material.dart';

class TodoDetailError extends StatelessWidget {
  const TodoDetailError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Error loading todo details"),
      ),
    );
  }
}