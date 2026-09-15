import 'package:flutter/material.dart';

import '../models/profile_menu_entry.dart';
import '../models/profile_stat.dart';
import '../widgets/go_pro_banner.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_stat_tile.dart';

/// The Profile tab: account summary, usage stats and settings menu.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeader(),
          const SizedBox(height: 18),
          ProfileCard(
            name: 'Abhay',
            email: 'abhay@example.com',
            isPro: true,
            onTap: () => _showComingSoon(context, 'Account coming soon'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < kProfileStats.length; i++) ...[
                Expanded(child: ProfileStatTile(stat: kProfileStats[i])),
                if (i != kProfileStats.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < kProfileMenuEntries.length; i++) ...[
            ProfileMenuItem(
              entry: kProfileMenuEntries[i],
              onTap: () => _showComingSoon(context, '${kProfileMenuEntries[i].title} coming soon'),
            ),
            if (i != kProfileMenuEntries.length - 1) const SizedBox(height: 10),
          ],
          const SizedBox(height: 20),
          GoProBanner(onTap: () => _showComingSoon(context, 'Premium coming soon')),
        ],
      ),
    );
  }
}
