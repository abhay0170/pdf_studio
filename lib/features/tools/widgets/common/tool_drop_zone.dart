import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// The dashed "select/add files" drop target shared by every tool detail
/// screen. [iconContent] is whatever sits inside the colored badge square
/// (a plain icon, or a Stack with a corner badge).
class ToolDropZone extends StatelessWidget {
  const ToolDropZone({
    super.key,
    required this.iconContent,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final Widget iconContent;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: '$title. $subtitle',
      button: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_radius),
          child: CustomPaint(
            painter: _DashedBorderPainter(color: colors.titleAccent.withValues(alpha: 0.45)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: colors.photosBadgeBackground.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(_radius),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colors.photosBadgeBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: iconContent,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colors.cardTitle),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.5, color: colors.docMeta, height: 1.35),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints an evenly-dashed rounded-rect outline — Flutter has no built-in
/// dashed border, so we trace the rrect path and stroke it in segments.
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color});

  final Color color;
  static const _dashWidth = 6.0;
  static const _dashGap = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(ToolDropZone._radius));
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + _dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + _dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => oldDelegate.color != color;
}
