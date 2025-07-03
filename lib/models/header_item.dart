import 'package:flutter/material.dart';

class HeaderItem {
  final String title;
  final VoidCallback onTap;
  final bool isButton;
  final GlobalKey? sectionKey;
  final Color? color;

  HeaderItem({
    required this.title,
    required this.onTap,
    this.isButton = false,
    this.sectionKey,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
