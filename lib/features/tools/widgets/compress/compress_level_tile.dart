import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/compress_level.dart';

/// One choice in the "Compression Level" row (High / Medium / Low).
class CompressLevelTile extends StatelessWidget {
  const CompressLevelTile({super.key, required this.level, required this.selected, this.onTap});

  final CompressLevel level;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = colors.titleAccent;
    final background = selected ? colors.photosBadgeBackground : colors.cardFlatBackground;
    final labelColor = selected ? accent : colors.cardTitle;

    return Semantics(
      label: '${level.label}, ${level.subtitle}',
      button: true,
      selected: selected,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? accent.withValues(alpha: 0.6) : Colors.transparent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                ],
                Text(level.label, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: labelColor)),
                const SizedBox(height: 2),
                Text(level.subtitle, style: TextStyle(fontSize: 11.5, color: colors.docMeta)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
