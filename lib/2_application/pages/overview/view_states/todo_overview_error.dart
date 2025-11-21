import 'package:flutter/material.dart';

class TodoOverviewError extends StatelessWidget {
  const TodoOverviewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('An unexpected error occurred. Please try again later.'),
      ),
    );
  }
}