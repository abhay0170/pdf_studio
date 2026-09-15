import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../providers/tools_provider.dart';

/// The horizontally-scrollable All / Edit / Convert / Organize / Security
/// chip row.
class ToolCategoryChips extends StatelessWidget {
  const ToolCategoryChips({super.key, required this.selected, required this.onSelected});

  final ToolCategoryFilter selected;
  final ValueChanged<ToolCategoryFilter> onSelected;

  static const _options = [
    (ToolCategoryFilter.all, 'All'),
    (ToolCategoryFilter.edit, 'Edit'),
    (ToolCategoryFilter.convert, 'Convert'),
    (ToolCategoryFilter.organize, 'Organize'),
    (ToolCategoryFilter.security, 'Security'),
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
