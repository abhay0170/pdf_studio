import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// The rounded "Search tools..." field below the Tools header.
class ToolSearchBar extends StatelessWidget {
  const ToolSearchBar({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      height: 52,
      decoration: BoxDecoration(color: colors.cardFlatBackground, borderRadius: BorderRadius.circular(26)),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 15, color: colors.docTitle),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: 'Search tools...',
          hintStyle: TextStyle(fontSize: 15, color: colors.cardSubtitleMuted),
          prefixIcon: Icon(Icons.search_rounded, color: colors.cardSubtitleMuted, size: 22),
          prefixIconConstraints: const BoxConstraints(minWidth: 46),
          suffixIcon: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              if (controller.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(Icons.close_rounded, color: colors.cardSubtitleMuted, size: 18),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        ),
      ),
    );
  }
}
