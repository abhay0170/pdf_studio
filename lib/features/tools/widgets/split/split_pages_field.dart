import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// "Pages per file" label + description + dropdown, shown under the split
/// options when By Pages is selected.
class SplitPagesField extends StatelessWidget {
  const SplitPagesField({super.key, required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  static const _options = [1, 2, 5, 10, 20];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pages per file',
          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
        ),
        const SizedBox(height: 2),
        Text('Number of pages in each split file.', style: TextStyle(fontSize: 12.5, color: colors.docMeta)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: colors.cardFlatBackground, borderRadius: BorderRadius.circular(14)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors.cardSubtitleMuted),
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: colors.cardTitle),
              dropdownColor: colors.cardFlatBackground,
              borderRadius: BorderRadius.circular(14),
              items: [for (final n in _options) DropdownMenuItem(value: n, child: Text('$n'))],
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
