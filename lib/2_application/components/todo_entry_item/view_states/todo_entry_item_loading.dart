import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoEntryItemLoading extends StatelessWidget {
  const TodoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(milliseconds: 800),
      interval: Duration(milliseconds: 300),
      color: Colors.grey.shade300,
      colorOpacity: 0.5,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        title: Container(
          width: double.infinity,
          height: 16,
          color: Colors.grey.shade300,
        ),
        subtitle: Container(
          width: double.infinity,
          height: 14,
          margin: EdgeInsets.only(top: 8),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}