import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/profile_stat.dart';

/// One tile in the 4-up stats row (Documents / Tools Used / This Week / Plan).
class ProfileStatTile extends StatelessWidget {
  const ProfileStatTile({super.key, required this.stat});

  final ProfileStat stat;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: colors.cardFlatBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardSubtitleMuted.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(stat.icon, color: stat.color, size: 18),
          const SizedBox(height: 10),
          Text(stat.value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: colors.cardTitle)),
          const SizedBox(height: 2),
          Text(
            stat.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: colors.cardSubtitleMuted),
          ),
        ],
      ),
    );
  }
}
