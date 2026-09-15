import 'package:flutter/material.dart';

import '../../features/documents/screens/documents_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/tools/screens/tools_screen.dart';
import '../theme/app_colors.dart';

/// Hosts the four top-level tabs behind the bottom navigation bar.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const _tabs = [
    HomeScreen(),
    DocumentsScreen(),
    ToolsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _selectedIndex, children: _tabs),
      ),
      bottomNavigationBar: _BottomNav(
        selectedIndex: _selectedIndex,
        onSelect: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.activeIcon, required this.inactiveIcon, required this.label});

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _items = [
    _NavItem(activeIcon: Icons.home_rounded, inactiveIcon: Icons.home_outlined, label: 'Home'),
    _NavItem(activeIcon: Icons.folder_rounded, inactiveIcon: Icons.folder_outlined, label: 'Documents'),
    _NavItem(activeIcon: Icons.build_rounded, inactiveIcon: Icons.build_outlined, label: 'Tools'),
    _NavItem(activeIcon: Icons.person_rounded, inactiveIcon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      height: 80,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.screenBackground,
        border: Border(top: BorderSide(color: colors.navInactive.withValues(alpha: 0.15))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < _items.length; i++)
            _NavButton(item: _items[i], active: i == selectedIndex, onTap: () => onSelect(i)),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.item, required this.active, required this.onTap});

  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = active ? colors.navActive : colors.navInactive;
    return InkWell(
      onTap: onTap,
      customBorder: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(active ? item.activeIcon : item.inactiveIcon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(item.label, style: TextStyle(fontSize: 11.5, color: color)),
          ],
        ),
      ),
    );
  }
}
