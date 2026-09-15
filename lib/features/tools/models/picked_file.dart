import 'package:flutter/material.dart';

/// One PDF queued up in a tool (Merge, Split, ...), with the icon/color
/// used to represent its file type in a selected-files list.
class PickedFile {
  const PickedFile({
    required this.name,
    required this.pageCount,
    required this.sizeBytes,
    required this.icon,
    required this.color,
  });

  final String name;
  final int pageCount;
  final int sizeBytes;
  final IconData icon;
  final Color color;
}
