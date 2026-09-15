import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// One outlined password row in the "Set Password" section: a lock icon,
/// a masked input, and a trailing show/hide toggle.
class ProtectPasswordField extends StatefulWidget {
  const ProtectPasswordField({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  State<ProtectPasswordField> createState() => _ProtectPasswordFieldState();
}

class _ProtectPasswordFieldState extends State<ProtectPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.cardSubtitleMuted.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscured,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 14.5, color: colors.docTitle),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14.5, color: colors.cardSubtitleMuted),
          prefixIcon: Icon(Icons.lock_outline_rounded, color: colors.cardSubtitleMuted, size: 19),
          prefixIconConstraints: const BoxConstraints(minWidth: 44),
          suffixIcon: Semantics(
            label: _obscured ? 'Show password' : 'Hide password',
            button: true,
            child: IconButton(
              onPressed: () => setState(() => _obscured = !_obscured),
              icon: Icon(
                _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: colors.cardSubtitleMuted,
                size: 19,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        ),
      ),
    );
  }
}
