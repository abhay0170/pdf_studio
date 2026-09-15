import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../providers/documents_filter_provider.dart';

/// The "Recent ⌄" sort control and the trailing filter/sort icon.
class DocumentSortHeader extends StatelessWidget {
  const DocumentSortHeader({super.key, required this.selected, required this.onSelected});

  final DocumentSortOption selected;
  final ValueChanged<DocumentSortOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Semantics(
            label: 'Sort by ${selected.label}',
            button: true,
            child: PopupMenuButton<DocumentSortOption>(
              initialValue: selected,
              onSelected: onSelected,
              offset: const Offset(0, 36),
              color: colors.docCardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              itemBuilder: (context) => [
                for (final option in DocumentSortOption.values)
                  PopupMenuItem(
                    value: option,
                    child: Text(option.label, style: TextStyle(color: colors.docTitle)),
                  ),
              ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swap_vert_rounded, size: 18, color: colors.cardSubtitleMuted),
                  const SizedBox(width: 6),
                  Text(
                    selected.label,
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: colors.cardTitle),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: colors.cardSubtitleMuted),
                ],
              ),
            ),
          ),
          const Spacer(),
          Semantics(
            label: 'Filter options',
            button: true,
            child: Icon(Icons.tune_rounded, size: 20, color: colors.cardSubtitleMuted),
          ),
        ],
      ),
    );
  }
}
