import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// One of the two short pill buttons below the quick-action cards
/// ("Import", "All Tools").
class QuickActionPill extends StatelessWidget {
  const QuickActionPill({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: colors.cardFlatBackground,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: colors.cardTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
