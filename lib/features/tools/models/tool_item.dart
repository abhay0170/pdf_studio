import 'package:flutter/material.dart';

/// Which chip a tool shows under.
enum ToolCategory { edit, convert, organize, security }

/// One entry in the Tools grid.
class ToolItem {
  const ToolItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.category,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final ToolCategory category;
}
