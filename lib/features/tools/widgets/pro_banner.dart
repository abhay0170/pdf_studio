import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The "More powerful tools" upsell strip at the bottom of the Tools tab.
class ProBanner extends StatelessWidget {
  const ProBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: 'More powerful tools. Unlock the full potential with PDF Studio Pro.',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: colors.photosBadgeBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.titleAccent.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: colors.titleAccent, shape: BoxShape.circle),
                  child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'More powerful tools',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: colors.titleAccent),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Unlock the full potential with PDF Studio Pro.',
                        style: TextStyle(fontSize: 12, color: colors.docMeta),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.titleAccent, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
