import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// "PDF Studio" wordmark and the premium/crown button at the top of Home.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.onPremiumTap});

  final VoidCallback? onPremiumTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'PDF Studio',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
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
