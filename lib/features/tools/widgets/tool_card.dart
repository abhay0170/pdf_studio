import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/tool_item.dart';

/// One grid cell on the Tools tab: colored icon badge, title, subtitle and
/// a trailing chevron.
class ToolCard extends StatelessWidget {
  const ToolCard({super.key, required this.tool, this.onTap});

  final ToolItem tool;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: '${tool.title}. ${tool.subtitle}',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.cardFlatBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.cardSubtitleMuted.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: tool.color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(tool.icon, color: tool.color, size: 22),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, size: 20, color: colors.cardSubtitleMuted),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  tool.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colors.cardTitle),
                ),
                const SizedBox(height: 3),
                Text(
                  tool.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.5, color: colors.cardSubtitleMuted, height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
