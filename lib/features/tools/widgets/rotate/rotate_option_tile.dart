import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/rotate_mode.dart';

/// One choice in the "Rotation Options" row (90° CW / 90° CCW / 180° / Auto).
/// Selected state is a solid accent fill rather than the lighter tint other
/// tool tiles use, to match the Rotate screen's design.
class RotateOptionTile extends StatelessWidget {
  const RotateOptionTile({super.key, required this.mode, required this.selected, this.onTap});

  final RotateMode mode;
  final bool selected;
  final VoidCallback? onTap;

  static const _selectedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3D5CFF), Color(0xFF5B6EFF)],
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final foreground = selected ? Colors.white : colors.cardSubtitleMuted;
    final labelColor = selected ? Colors.white : colors.cardTitle;

    return Semantics(
      label: '${mode.label} ${mode.subtitle}',
      button: true,
      selected: selected,
      child: Material(
        color: selected ? null : colors.cardFlatBackground,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            decoration: BoxDecoration(
              gradient: selected ? _selectedGradient : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(mode.icon, size: 20, color: foreground),
                const SizedBox(height: 8),
                Text(mode.label, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: labelColor)),
                const SizedBox(height: 1),
                Text(
                  mode.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: foreground, height: 1.15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
