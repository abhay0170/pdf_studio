import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/extract_mode.dart';

/// One choice in the Images / Pages / Text / Data row.
class ExtractModeTile extends StatelessWidget {
  const ExtractModeTile({super.key, required this.mode, required this.selected, this.onTap});

  final ExtractMode mode;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = colors.titleAccent;
    final background = selected ? colors.photosBadgeBackground : colors.cardFlatBackground;
    final foreground = selected ? accent : colors.cardTitle;

    return Semantics(
      label: '${mode.label}, ${mode.subtitle}',
      button: true,
      selected: selected,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? accent.withValues(alpha: 0.6) : Colors.transparent),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(mode.icon, size: 20, color: foreground),
                const SizedBox(height: 6),
                Text(mode.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: foreground)),
                const SizedBox(height: 2),
                Text(
                  mode.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.5, color: colors.docMeta),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
