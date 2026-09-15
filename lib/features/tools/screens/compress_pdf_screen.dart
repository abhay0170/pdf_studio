import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/compress_level.dart';
import '../models/picked_file.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/compress/compress_estimated_size_tile.dart';
import '../widgets/compress/compress_level_tile.dart';

/// The Compress PDF tool: pick one file, choose a compression level, and
/// shrink it.
class CompressPdfScreen extends StatefulWidget {
  const CompressPdfScreen({super.key});

  @override
  State<CompressPdfScreen> createState() => _CompressPdfScreenState();
}

class _CompressPdfScreenState extends State<CompressPdfScreen> {
  final PickedFile? _file = const PickedFile(
    name: 'Project Proposal.pdf',
    pageCount: 12,
    sizeBytes: 2516582,
    icon: Icons.picture_as_pdf_rounded,
    color: Color(0xFFEF4444),
  );

  CompressLevel _level = CompressLevel.high;

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
                title: 'Compress PDF',
                subtitle: 'Reduce file size without losing quality.',
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
                    iconContent: _CompressDropIcon(color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Compression Level',
                            style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.info_outline_rounded, size: 16, color: colors.cardSubtitleMuted),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _showComingSoon('Compression details coming soon'),
                        child: Text(
                          'How it works?',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.seeAllLink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CompressLevelTile(
                          level: CompressLevel.high,
                          selected: _level == CompressLevel.high,
                          onTap: () => setState(() => _level = CompressLevel.high),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CompressLevelTile(
                          level: CompressLevel.medium,
                          selected: _level == CompressLevel.medium,
                          onTap: () => setState(() => _level = CompressLevel.medium),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CompressLevelTile(
                          level: CompressLevel.low,
                          selected: _level == CompressLevel.low,
                          onTap: () => setState(() => _level = CompressLevel.low),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CompressEstimatedSizeTile(onTap: () => _showComingSoon('Estimated size coming soon')),
                  const SizedBox(height: 20),
                  ToolActionButton(
                    icon: Icons.compress_rounded,
                    label: 'Compress PDF',
                    enabled: file != null,
                    onTap: file != null ? () => _showComingSoon('Compressing ${file.name}…') : null,
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

class _CompressDropIcon extends StatelessWidget {
  const _CompressDropIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.picture_as_pdf_rounded, size: 24, color: color),
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
