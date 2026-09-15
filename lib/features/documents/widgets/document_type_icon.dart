import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The rounded-square PDF icon on a document card.
class DocumentTypeIcon extends StatelessWidget {
  const DocumentTypeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colors.destructive.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(Icons.picture_as_pdf_rounded, color: colors.destructive, size: 22),
    );
  }
}
