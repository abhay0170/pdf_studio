import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../providers/documents_filter_provider.dart';

/// The horizontally-scrollable All / Scans / Imported / Shared chip row.
class DocumentCategoryChips extends StatelessWidget {
  const DocumentCategoryChips({super.key, required this.selected, required this.onSelected});

  final DocumentCategoryFilter selected;
  final ValueChanged<DocumentCategoryFilter> onSelected;

  static const _options = [
    (DocumentCategoryFilter.all, 'All'),
    (DocumentCategoryFilter.scans, 'Scans'),
    (DocumentCategoryFilter.imported, 'Imported'),
    (DocumentCategoryFilter.shared, 'Shared'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final (value, label) = _options[index];
          final isSelected = value == selected;
          return Semantics(
            label: label,
            button: true,
            selected: isSelected,
            child: Material(
              color: isSelected ? colors.titleAccent : colors.cardFlatBackground,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                onTap: () => onSelected(value),
                borderRadius: BorderRadius.circular(22),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : colors.cardTitle,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
