import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The "Go Pro" upsell strip at the bottom of the Profile tab.
class GoProBanner extends StatelessWidget {
  const GoProBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  static const _accent = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: 'Go Pro. Unlock all features and get the most out of PDF Studio.',
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
              color: _accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _accent.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                  child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Go Pro',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: _accent),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Unlock all features and get the most out of PDF Studio.',
                        style: TextStyle(fontSize: 12, color: colors.docMeta),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: _accent, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
