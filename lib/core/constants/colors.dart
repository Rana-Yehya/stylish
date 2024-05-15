import 'package:flutter/material.dart';

extension getColor on String {
  Color colorFronString() {
    switch (this) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      case 'blue':
        return Color(0xFF1A7E96);
      case 'mustard':
        return Color(0xFFC78104);
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
