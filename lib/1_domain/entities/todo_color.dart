import 'package:flutter/material.dart';

class TodoColor {
  final int colorIndex;

  static const List<Color> predefinedColors = [
    Color(0xFF000000),
    Color(0xFFFFFFFF),
    Color(0xFFFF0000),
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  Color get color => predefinedColors[colorIndex];
  const TodoColor({required this.colorIndex});
}
