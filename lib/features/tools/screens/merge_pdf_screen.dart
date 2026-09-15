import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/picked_file.dart';
import '../widgets/common/tool_action_button.dart';
import '../widgets/common/tool_drop_zone.dart';
import '../widgets/common/tool_header.dart';
import '../widgets/merge/merge_file_tile.dart';
import '../widgets/merge/merge_output_settings_tile.dart';

/// The Merge PDF tool: pick files, reorder them, and merge into one PDF.
class MergePdfScreen extends StatefulWidget {
  const MergePdfScreen({super.key});

  @override
  State<MergePdfScreen> createState() => _MergePdfScreenState();
}

class _MergePdfScreenState extends State<MergePdfScreen> {
  final List<PickedFile> _files = [
    const PickedFile(
      name: 'Project Proposal.pdf',
      pageCount: 12,
      sizeBytes: 2516582,
      icon: Icons.picture_as_pdf_rounded,
      color: Color(0xFFEF4444),
    ),
    const PickedFile(
      name: 'Design Specs.pdf',
      pageCount: 8,
      sizeBytes: 1887437,
      icon: Icons.image_rounded,
      color: Color(0xFF8B5CF6),
    ),
    const PickedFile(
      name: 'Meeting Notes.pdf',
      pageCount: 4,
      sizeBytes: 1003520,
      icon: Icons.description_rounded,
      color: Color(0xFF10B981),
    ),
  ];

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  void _clearAll() => setState(_files.clear);

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      final file = _files.removeAt(oldIndex);
      _files.insert(newIndex, file);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final canMerge = _files.length >= 2;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: ToolHeader(
                title: 'Merge PDF',
                subtitle: 'Combine multiple PDFs into one file.',
                onBack: () => Navigator.of(context).maybePop(),
                onBrowseFolder: () => _showComingSoon('Browse folder coming soon'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  ToolDropZone(
                    title: 'Add PDF Files',
                    subtitle: 'Tap to browse or drag and drop files here',
                    iconContent: Icon(Icons.post_add_rounded, size: 26, color: colors.titleAccent),
                    onTap: () => _showComingSoon('File picker coming soon'),
                  ),
                  const SizedBox(height: 24),
                  if (_files.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Files (${_files.length})',
                          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: colors.sectionTitle),
                        ),
                        Semantics(
                          label: 'Clear all selected files',
                          button: true,
                          child: InkWell(
                            onTap: _clearAll,
                            child: Text(
                              'Clear All',
                              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: colors.titleAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      buildDefaultDragHandles: false,
                      itemCount: _files.length,
                      onReorderItem: _reorder,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        return Padding(
                          key: ValueKey('${file.name}-$index'),
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MergeFileTile(
                            file: file,
                            index: index,
                            dragHandle: ReorderableDragStartListener(
                              index: index,
                              child: Icon(Icons.drag_handle_rounded, color: colors.cardSubtitleMuted),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  MergeOutputSettingsTile(onTap: () => _showComingSoon('Output settings coming soon')),
                  const SizedBox(height: 20),
                  ToolActionButton(
                    icon: Icons.call_merge_rounded,
                    label: 'Merge PDF',
                    enabled: canMerge,
                    onTap: canMerge ? () => _showComingSoon('Merging ${_files.length} files…') : null,
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
