import 'package:flutter/material.dart';

/// One row in the settings menu list.
class ProfileMenuEntry {
  const ProfileMenuEntry({required this.icon, required this.title, required this.subtitle, required this.color});

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}

const List<ProfileMenuEntry> kProfileMenuEntries = [
  ProfileMenuEntry(
    icon: Icons.person_rounded,
    title: 'Account Information',
    subtitle: 'Manage your personal details',
    color: Color(0xFF3B82F6),
  ),
  ProfileMenuEntry(
    icon: Icons.workspace_premium_rounded,
    title: 'Subscription',
    subtitle: 'View plan details and billing',
    color: Color(0xFF6366F1),
  ),
  ProfileMenuEntry(
    icon: Icons.cloud_rounded,
    title: 'Storage',
    subtitle: 'Manage your storage space',
    color: Color(0xFF10B981),
  ),
  ProfileMenuEntry(
    icon: Icons.notifications_rounded,
    title: 'Notifications',
    subtitle: 'Control your alerts and updates',
    color: Color(0xFFF97316),
  ),
  ProfileMenuEntry(
    icon: Icons.help_rounded,
    title: 'Help & Support',
    subtitle: 'Get help or contact us',
    color: Color(0xFFA855F7),
  ),
  ProfileMenuEntry(
    icon: Icons.info_rounded,
    title: 'About',
    subtitle: 'App version, terms and privacy',
    color: Color(0xFF6B7280),
  ),
];
