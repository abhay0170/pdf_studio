import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/extracted_file.dart';

/// One row in the "Recent Extracted Files" list: type icon, name/meta, and
/// download / more actions.
class ExtractedFileTile extends StatelessWidget {
  const ExtractedFileTile({super.key, required this.file, this.onDownload, this.onMore});

  final ExtractedFile file;
  final VoidCallback? onDownload;
  final VoidCallback? onMore;

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
            decoration: BoxDecoration(color: file.color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(13)),
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
                Text(file.meta, style: TextStyle(fontSize: 12, color: colors.docMeta)),
              ],
            ),
          ),
          IconButton(
            onPressed: onDownload,
            icon: Icon(Icons.file_download_outlined, color: colors.titleAccent, size: 20),
          ),
          IconButton(
            onPressed: onMore,
            icon: Icon(Icons.more_vert_rounded, color: colors.docMeta, size: 20),
          ),
        ],
      ),
    );
  }
}
