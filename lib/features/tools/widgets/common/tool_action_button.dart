import 'package:flutter/material.dart';

/// The gradient primary call-to-action pinned at the bottom of a tool
/// screen (e.g. "Merge PDF", "Split PDF"). Dims when [enabled] is false.
class ToolActionButton extends StatelessWidget {
  const ToolActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.enabled,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  static const _gradient = LinearGradient(colors: [Color(0xFF3D5CFF), Color(0xFF6D5CFF)]);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              height: 54,
              decoration: BoxDecoration(gradient: _gradient, borderRadius: BorderRadius.circular(28)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
