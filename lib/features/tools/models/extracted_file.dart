import 'package:flutter/material.dart';

/// One row in the "Recent Extracted Files" list.
class ExtractedFile {
  const ExtractedFile({required this.name, required this.meta, required this.icon, required this.color});

  final String name;
  final String meta;
  final IconData icon;
  final Color color;
}
