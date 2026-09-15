import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The floating "Scan" pill anchored above the bottom nav on the
/// Documents tab.
class ScanFabButton extends StatelessWidget {
  const ScanFabButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: 'Scan new document',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              gradient: colors.scanGradient,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: colors.docBadgeIcon.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Scan',
                  style: TextStyle(color: Colors.white, fontSize: 15.5, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
