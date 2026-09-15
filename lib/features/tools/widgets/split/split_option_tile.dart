import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// One segmented choice in the "Split Options" row (By Pages / By Range /
/// By Size).
class SplitOptionTile extends StatelessWidget {
  const SplitOptionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = colors.titleAccent;
    final background = selected ? colors.photosBadgeBackground : colors.cardFlatBackground;
    final foreground = selected ? accent : colors.cardSubtitleMuted;

    return Semantics(
      label: label,
      button: true,
      selected: selected,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? accent.withValues(alpha: 0.6) : Colors.transparent),
            ),
            child: Column(
              children: [
                Icon(icon, size: 20, color: foreground),
                const SizedBox(height: 6),
                Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: foreground)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
