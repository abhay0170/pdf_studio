import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Back button, gradient title + subtitle, and a trailing "browse folder"
/// button shared by every tool detail screen (Merge, Split, ...).
class ToolHeader extends StatelessWidget {
  const ToolHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.onBrowseFolder,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onBrowseFolder;

  static const _gradient = LinearGradient(colors: [Color(0xFF3D5CFF), Color(0xFF8B5CF6)]);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: 'Back',
          button: true,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: colors.cardTitle),
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => _gradient.createShader(bounds),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(subtitle, style: TextStyle(fontSize: 13, color: colors.docMeta)),
              ],
            ),
          ),
        ),
        Semantics(
          label: 'Browse folder',
          button: true,
          child: Material(
            color: colors.cardFlatBackground,
            borderRadius: BorderRadius.circular(13),
            child: InkWell(
              onTap: onBrowseFolder,
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.folder_open_rounded, size: 20, color: colors.cardTitle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
