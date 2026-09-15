import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// "PDF Studio" wordmark and the profile avatar at the top of Home.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.onAvatarTap});

  final VoidCallback? onAvatarTap;

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
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: colors.chipDark,
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
