import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/extract_mode.dart';
import '../models/extracted_file.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/extract/extract_info_tile.dart';
import '../widgets/extract/extract_mode_tile.dart';
import '../widgets/extract/extracted_file_tile.dart';

/// The Extract tool: pull images, pages, text or tables out of a PDF.
class ExtractPdfScreen extends StatefulWidget {
  const ExtractPdfScreen({super.key});

  @override
  State<ExtractPdfScreen> createState() => _ExtractPdfScreenState();
}

class _ExtractPdfScreenState extends State<ExtractPdfScreen> {
  ExtractMode _mode = ExtractMode.images;

  static const _recentFiles = [
    ExtractedFile(
      name: 'images_20240911.zip',
      meta: '3 images · 2.4 MB',
      icon: Icons.image_rounded,
      color: Color(0xFF3B82F6),
    ),
    ExtractedFile(
      name: 'pages_20240910.pdf',
      meta: '5 pages · 1.8 MB',
      icon: Icons.description_rounded,
      color: Color(0xFF10B981),
    ),
    ExtractedFile(
      name: 'text_20240908.txt',
      meta: 'Extracted text · 256 KB',
      icon: Icons.text_snippet_rounded,
      color: Color(0xFFA855F7),
    ),
  ];

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
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
                title: 'Extract',
                subtitle: 'Pull out pages, images or text from your PDF.',
                onBack: () => Navigator.of(context).maybePop(),
                onBrowseFolder: () => _showComingSoon('Browse folder coming soon'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  Row(
                    children: [
                      for (final mode in ExtractMode.values) ...[
                        Expanded(
                          child: ExtractModeTile(
                            mode: mode,
                            selected: _mode == mode,
                            onTap: () => setState(() => _mode = mode),
                          ),
                        ),
                        if (mode != ExtractMode.values.last) const SizedBox(width: 8),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  ToolDropZone(
                    title: 'Select PDF File',
                    subtitle: 'Tap to browse or drag and drop file here',
                    iconContent: _ExtractDropIcon(mode: _mode, color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 20),
                  ExtractInfoTile(onTap: () => _showComingSoon('More about extracting coming soon')),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Extracted Files',
                        style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                      ),
                      GestureDetector(
                        onTap: () => _showComingSoon('View all coming soon'),
                        child: Text(
                          'View all',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.seeAllLink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (final file in _recentFiles) ...[
                    ExtractedFileTile(
                      file: file,
                      onDownload: () => _showComingSoon('Downloading ${file.name}…'),
                      onMore: () => _showComingSoon('More options coming soon'),
                    ),
                    if (file != _recentFiles.last) const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 20),
                  ToolActionButton(
                    icon: Icons.file_download_rounded,
                    label: 'Extract',
                    enabled: true,
                    onTap: () => _showComingSoon('Extracting ${_mode.label.toLowerCase()}…'),
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

class _ExtractDropIcon extends StatelessWidget {
  const _ExtractDropIcon({required this.mode, required this.color});

  final ExtractMode mode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.insert_drive_file_outlined, size: 24, color: color),
        Positioned(
          top: 6,
          right: 4,
          child: Icon(mode.icon, size: 11, color: color),
        ),
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
