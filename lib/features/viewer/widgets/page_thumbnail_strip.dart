import 'package:flutter/material.dart';

/// Scrollable strip of page thumbnails along the bottom of the viewer.
/// Rendering is not wired up yet — lands with the rest of the viewer feature.
class PageThumbnailStrip extends StatelessWidget {
  const PageThumbnailStrip({super.key, required this.pageCount});

  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
