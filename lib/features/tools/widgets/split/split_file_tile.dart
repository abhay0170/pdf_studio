import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/utils/file_size_formatter.dart';
import '../../models/picked_file.dart';

/// The single selected-file row on the Split PDF screen: type icon,
/// name/meta, and a trailing remove button.
class SplitFileTile extends StatelessWidget {
  const SplitFileTile({super.key, required this.file, this.onRemove});

  final PickedFile file;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: colors.cardFlatBackground, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
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
          Semantics(
            label: 'Remove ${file.name}',
            button: true,
            child: IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.close_rounded, size: 20, color: colors.cardSubtitleMuted),
            ),
          ),
        ],
      ),
    );
  }
}
