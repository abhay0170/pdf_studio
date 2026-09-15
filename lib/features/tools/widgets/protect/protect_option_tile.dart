import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/protection_option.dart';

/// One choice in the "Protection Options" row. Selected state is a solid
/// accent fill with a small checkmark badge floating at the top-right
/// corner, matching the Protect screen's design.
class ProtectOptionTile extends StatelessWidget {
  const ProtectOptionTile({super.key, required this.option, required this.selected, this.onTap});

  final ProtectionOption option;
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
      label: '${option.label}, ${option.subtitle}',
      button: true,
      selected: selected,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: selected ? null : colors.cardFlatBackground,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 3),
                decoration: BoxDecoration(
                  gradient: selected ? _selectedGradient : null,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: selected ? Colors.transparent : colors.cardSubtitleMuted.withValues(alpha: 0.18)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(option.icon, size: 22, color: foreground),
                    const SizedBox(height: 8),
                    Text(
                      option.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: labelColor, height: 1.2),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      option.subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: foreground, height: 1.15),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selected)
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: colors.screenBackground,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 4)],
                ),
                alignment: Alignment.center,
                child: Icon(Icons.check_circle_rounded, size: 18, color: colors.titleAccent),
              ),
            ),
        ],
      ),
    );
  }
}
