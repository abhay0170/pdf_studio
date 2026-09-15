import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../shared/utils/file_size_formatter.dart';
import '../../documents/models/document_model.dart';

/// One row in the "Recent Documents" list on Home.
class RecentDocumentCard extends StatelessWidget {
  const RecentDocumentCard({super.key, required this.document, this.onTap, this.onMenuTap});

  final DocumentModel document;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String get _meta {
    final pages = document.pageCount == 1 ? '1 page' : '${document.pageCount} pages';
    final size = formatFileSize(document.sizeBytes);
    final date = '${_months[document.modifiedAt.month - 1]} ${document.modifiedAt.day}';
    return '$pages · $size · $date';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 84,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: colors.docCardBackground, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: colors.docBadgeBackground, borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.picture_as_pdf_rounded, color: colors.docBadgeIcon, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colors.docTitle),
                    ),
                    const SizedBox(height: 3),
                    Text(_meta, style: TextStyle(fontSize: 12.5, color: colors.docMeta)),
                  ],
                ),
              ),
              IconButton(
                onPressed: onMenuTap,
                icon: Icon(Icons.more_vert_rounded, color: colors.docMeta),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
