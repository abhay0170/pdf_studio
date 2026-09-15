import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// The "Output Settings" row above the Merge button.
class MergeOutputSettingsTile extends StatelessWidget {
  const MergeOutputSettingsTile({super.key, this.subtitle = 'Default (Keep all pages)', this.onTap});

  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: 'Output settings. $subtitle',
      button: true,
      child: Material(
        color: colors.cardFlatBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.photosBadgeBackground,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.settings_rounded, size: 18, color: colors.titleAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Output Settings',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: colors.cardTitle),
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle, style: TextStyle(fontSize: 12, color: colors.docMeta)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, size: 20, color: colors.cardSubtitleMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
