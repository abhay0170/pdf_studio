import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Shared empty-state layout for "no documents yet", "no search results" and
/// "no documents in this category".
class DocumentsEmptyState extends StatelessWidget {
  const DocumentsEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(color: colors.cardFlatBackground, shape: BoxShape.circle),
              child: Icon(icon, size: 30, color: colors.cardSubtitleMuted),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w700, color: colors.cardTitle),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: colors.docMeta, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
