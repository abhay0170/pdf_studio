import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Page title + premium/crown button at the top of the Tools tab.
class ToolsHeader extends StatelessWidget {
  const ToolsHeader({super.key, this.onPremiumTap});

  final VoidCallback? onPremiumTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
