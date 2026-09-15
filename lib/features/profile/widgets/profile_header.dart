import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Page title at the top of the Profile tab.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Text(
      'Profile',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: colors.titleAccent,
      ),
    );
  }
}
