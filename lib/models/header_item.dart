import 'package:flutter/cupertino.dart';

class HeaderItem {
  final String title;
  final VoidCallback onTap;
  final bool isButton;
  final GlobalKey? sectionKey;

  HeaderItem({
    required this.title,
    required this.onTap,
    this.isButton = false,
    this.sectionKey,
  });
}
