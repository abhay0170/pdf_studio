import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/utils/file_size_formatter.dart';
import '../../models/picked_file.dart';

/// One row in the Merge PDF selected-files list: order badge, type icon,
/// name/meta, and an optional trailing drag handle for reordering.
class MergeFileTile extends StatelessWidget {
  const MergeFileTile({super.key, required this.file, required this.index, this.dragHandle});

  final PickedFile file;
  final int index;
  final Widget? dragHandle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: colors.cardFlatBackground, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: colors.photosBadgeBackground, shape: BoxShape.circle),
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: colors.titleAccent),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: file.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(file.icon, color: file.color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: colors.docTitle),
                ),
                const SizedBox(height: 3),
                Text(
                  '${file.pageCount} pages · ${formatFileSize(file.sizeBytes)}',
                  style: TextStyle(fontSize: 12, color: colors.docMeta),
                ),
              ],
            ),
          ),
          if (dragHandle != null) dragHandle!,
        ],
      ),
    );
  }
}
