import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Page title + settings gear button at the top of the Profile tab.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.onSettingsTap});

  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: colors.titleAccent,
          ),
        ),
        Semantics(
          label: 'Settings',
          button: true,
          child: Material(
            color: colors.cardFlatBackground,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onSettingsTap,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.settings_rounded, color: colors.cardTitle, size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
