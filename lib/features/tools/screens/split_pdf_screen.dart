import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/picked_file.dart';
import '../models/split_mode.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/split/split_file_tile.dart';
import '../widgets/split/split_option_tile.dart';
import '../widgets/split/split_pages_field.dart';

/// The Split PDF tool: pick one file, choose a split strategy, and split it
/// into multiple files.
class SplitPdfScreen extends StatefulWidget {
  const SplitPdfScreen({super.key});

  @override
  State<SplitPdfScreen> createState() => _SplitPdfScreenState();
}

class _SplitPdfScreenState extends State<SplitPdfScreen> {
  PickedFile? _file = const PickedFile(
    name: 'Project Proposal.pdf',
    pageCount: 12,
    sizeBytes: 2516582,
    icon: Icons.picture_as_pdf_rounded,
    color: Color(0xFFEF4444),
  );

  SplitMode _mode = SplitMode.byPages;
  int _pagesPerFile = 1;

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
                title: 'Split PDF',
                subtitle: 'Split a PDF into multiple files.',
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
                    iconContent: _SplitDropIcon(color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Split Options',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SplitOptionTile(
                          icon: Icons.description_outlined,
                          label: 'By Pages',
                          selected: _mode == SplitMode.byPages,
                          onTap: () => setState(() => _mode = SplitMode.byPages),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SplitOptionTile(
                          icon: Icons.file_copy_outlined,
                          label: 'By Range',
                          selected: _mode == SplitMode.byRange,
                          onTap: () => setState(() => _mode = SplitMode.byRange),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SplitOptionTile(
                          icon: Icons.zoom_out_map_rounded,
                          label: 'By Size',
                          selected: _mode == SplitMode.bySize,
                          onTap: () => setState(() => _mode = SplitMode.bySize),
                        ),
                      ),
                    ],
                  ),
                  if (_mode == SplitMode.byPages) ...[
                    const SizedBox(height: 20),
                    SplitPagesField(
                      value: _pagesPerFile,
                      onChanged: (value) => setState(() => _pagesPerFile = value),
                    ),
                  ],
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
                    icon: Icons.tune_rounded,
                    label: 'Split PDF',
                    enabled: file != null,
                    onTap: file != null ? () => _showComingSoon('Splitting ${file.name}…') : null,
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

class _SplitDropIcon extends StatelessWidget {
  const _SplitDropIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.splitscreen_rounded, size: 24, color: color),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const Icon(Icons.add_rounded, size: 11, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
