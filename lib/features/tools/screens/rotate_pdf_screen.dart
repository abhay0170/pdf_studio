import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/picked_file.dart';
import '../models/rotate_mode.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/rotate/rotate_option_tile.dart';
import '../widgets/split/split_file_tile.dart';

/// The Rotate PDF tool: pick one file, choose a rotation, and apply it.
class RotatePdfScreen extends StatefulWidget {
  const RotatePdfScreen({super.key});

  @override
  State<RotatePdfScreen> createState() => _RotatePdfScreenState();
}

class _RotatePdfScreenState extends State<RotatePdfScreen> {
  PickedFile? _file = const PickedFile(
    name: 'Project Proposal.pdf',
    pageCount: 12,
    sizeBytes: 2516582,
    icon: Icons.picture_as_pdf_rounded,
    color: Color(0xFFEF4444),
  );

  RotateMode _mode = RotateMode.clockwise90;

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final file = _file;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: ToolHeader(
                title: 'Rotate PDF',
                subtitle: 'Rotate your PDF pages to the desired orientation.',
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
                    iconContent: _RotateDropIcon(color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Rotation Options',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                  ),
                  const SizedBox(height: 12),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final mode in RotateMode.values) ...[
                          Expanded(
                            child: RotateOptionTile(
                              mode: mode,
                              selected: _mode == mode,
                              onTap: () => setState(() => _mode = mode),
                            ),
                          ),
                          if (mode != RotateMode.values.last) const SizedBox(width: 10),
                        ],
                      ],
                    ),
                  ),
                  if (file != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Selected File',
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                    ),
                    const SizedBox(height: 12),
                    SplitFileTile(file: file, onRemove: () => setState(() => _file = null)),
                  ],
                  const SizedBox(height: 20),
                  ToolActionButton(
                    icon: Icons.rotate_right_rounded,
                    label: 'Rotate PDF',
                    enabled: file != null,
                    onTap: file != null ? () => _showComingSoon('Rotating ${file.name}…') : null,
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

class _RotateDropIcon extends StatelessWidget {
  const _RotateDropIcon({required this.color});

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
            child: const Icon(Icons.sync_rounded, size: 11, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
