import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The avatar + name + email + Pro Member badge card at the top of Profile.
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.isPro = false,
    this.onTap,
  });

  final String name;
  final String email;
  final bool isPro;
  final VoidCallback? onTap;

  static const _accent = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: '$name, $email${isPro ? ', Pro member' : ''}',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _accent.withValues(alpha: 0.18)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                  child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: colors.cardTitle),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: colors.cardSubtitleMuted),
                      ),
                      if (isPro) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _accent.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.workspace_premium_rounded, color: _accent, size: 13),
                              SizedBox(width: 4),
                              Text(
                                'Pro Member',
                                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _accent),
                              ),
                            ],
                          ),
                        ),
                      ],
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
