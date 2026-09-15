import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// One of the two big cards at the top of Home ("Scan", "Photos"). Set
/// [highlighted] for the gradient hero card; leave it off for a flat card
/// with a tinted badge.
class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.highlighted = false,
    this.badgeBackground,
    this.badgeIconColor,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool highlighted;
  final Color? badgeBackground;
  final Color? badgeIconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final titleColor = highlighted ? Colors.white : colors.cardTitle;
    final subtitleColor = highlighted ? Colors.white.withValues(alpha: 0.85) : colors.cardSubtitleMuted;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 158,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: highlighted ? colors.scanGradient : null,
            color: highlighted ? null : colors.cardFlatBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: highlighted ? Colors.white.withValues(alpha: 0.18) : badgeBackground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: highlighted ? Colors.white : badgeIconColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: titleColor),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: subtitleColor)),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: colors.chipDark, shape: BoxShape.circle),
                  child: const Icon(Icons.north_east_rounded, color: Colors.white, size: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
