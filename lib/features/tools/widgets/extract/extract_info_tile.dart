import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// The "You can extract multiple items..." hint row above the file list.
class ExtractInfoTile extends StatelessWidget {
  const ExtractInfoTile({
    super.key,
    this.message = 'You can extract multiple items from a single PDF file.',
    this.onTap,
  });

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: message,
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
                  child: Icon(Icons.tips_and_updates_rounded, size: 18, color: colors.titleAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(message, style: TextStyle(fontSize: 13, color: colors.cardTitle, height: 1.3)),
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
