import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Page title + subtitle + premium/crown button at the top of the Tools tab.
class ToolsHeader extends StatelessWidget {
  const ToolsHeader({super.key, this.onPremiumTap});

  final VoidCallback? onPremiumTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tools',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: colors.titleAccent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Everything you need to edit and manage your PDF files.',
                style: TextStyle(fontSize: 13.5, color: colors.docMeta, height: 1.35),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Semantics(
          label: 'Premium',
          button: true,
          child: Material(
            color: colors.chipDark,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onPremiumTap,
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
