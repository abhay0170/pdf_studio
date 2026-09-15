import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/profile_menu_entry.dart';

/// One full-width row in the Profile settings menu.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({super.key, required this.entry, this.onTap});

  final ProfileMenuEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: '${entry.title}. ${entry.subtitle}',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: colors.cardFlatBackground, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(entry.icon, color: entry.color, size: 19),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.title,
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: colors.cardTitle),
                      ),
                      const SizedBox(height: 2),
                      Text(entry.subtitle, style: TextStyle(fontSize: 12, color: colors.cardSubtitleMuted)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.cardSubtitleMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
