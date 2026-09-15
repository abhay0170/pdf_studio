import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/protection_option.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/protect/protect_option_tile.dart';
import '../widgets/protect/protect_password_field.dart';

/// The Protect PDF tool: pick one file, choose a safeguard, and set a
/// password.
class ProtectPdfScreen extends StatefulWidget {
  const ProtectPdfScreen({super.key});

  @override
  State<ProtectPdfScreen> createState() => _ProtectPdfScreenState();
}

class _ProtectPdfScreenState extends State<ProtectPdfScreen> {
  ProtectionOption _option = ProtectionOption.passwordProtect;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: ToolHeader(
                title: 'Protect PDF',
                subtitle: 'Add a password and keep your PDF safe.',
                onBack: () => Navigator.of(context).maybePop(),
                onBrowseFolder: () => _showComingSoon('Browse folder coming soon'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  ToolDropZone(
                    title: 'Select PDF File',
                    subtitle: 'Tap to browse or drag and drop file here',
                    iconContent: _ProtectDropIcon(color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Protection Options',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                  ),
                  const SizedBox(height: 14),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final option in ProtectionOption.values) ...[
                          Expanded(
                            child: ProtectOptionTile(
                              option: option,
                              selected: _option == option,
                              onTap: () => setState(() => _option = option),
                            ),
                          ),
                          if (option != ProtectionOption.values.last) const SizedBox(width: 10),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Set Password',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                  ),
                  const SizedBox(height: 12),
                  ProtectPasswordField(controller: _passwordController, hintText: 'Enter password'),
                  const SizedBox(height: 10),
                  ProtectPasswordField(controller: _confirmPasswordController, hintText: 'Confirm password'),
                  const SizedBox(height: 8),
                  Text('Use at least 6 characters', style: TextStyle(fontSize: 12, color: colors.docMeta)),
                  const SizedBox(height: 20),
                  ToolActionButton(
                    icon: Icons.shield_rounded,
                    label: 'Protect PDF',
                    enabled: true,
                    onTap: () => _showComingSoon('Protecting PDF…'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProtectDropIcon extends StatelessWidget {
  const _ProtectDropIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.insert_drive_file_outlined, size: 24, color: color),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const Icon(Icons.lock_rounded, size: 10, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
