import 'package:flutter/material.dart';

/// One tile in the stats row (documents count, tools used, ...).
class ProfileStat {
  const ProfileStat({required this.icon, required this.value, required this.label, required this.color});

  final IconData icon;
  final String value;
  final String label;
  final Color color;
}

const List<ProfileStat> kProfileStats = [
  ProfileStat(icon: Icons.description_rounded, value: '12', label: 'Documents', color: Color(0xFF3B82F6)),
  ProfileStat(icon: Icons.apps_rounded, value: '8', label: 'Tools Used', color: Color(0xFF10B981)),
  ProfileStat(icon: Icons.trending_up_rounded, value: '5', label: 'This Week', color: Color(0xFF8B5CF6)),
  ProfileStat(icon: Icons.workspace_premium_rounded, value: 'Pro', label: 'Plan', color: Color(0xFF6366F1)),
];
