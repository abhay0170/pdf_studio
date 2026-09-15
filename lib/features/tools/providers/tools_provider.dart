import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tool_item.dart';

/// The category chips on the Tools tab.
enum ToolCategoryFilter { all, edit, convert, organize, security }

/// The fixed catalog of PDF tools shown in the grid.
const List<ToolItem> kToolCatalog = [
  ToolItem(
    id: 'merge',
    title: 'Merge',
    subtitle: 'Combine multiple PDFs into one.',
    icon: Icons.merge_rounded,
    color: Color(0xFF8B5CF6),
    category: ToolCategory.organize,
  ),
  ToolItem(
    id: 'split',
    title: 'Split',
    subtitle: 'Split a PDF into multiple files.',
    icon: Icons.content_cut_rounded,
    color: Color(0xFFE11D67),
    category: ToolCategory.organize,
  ),
  ToolItem(
    id: 'compress',
    title: 'Compress',
    subtitle: 'Reduce file size without losing quality.',
    icon: Icons.compress_rounded,
    color: Color(0xFF10B981),
    category: ToolCategory.organize,
  ),
  ToolItem(
    id: 'extract',
    title: 'Extract',
    subtitle: 'Pull out pages, images or text from your PDF.',
    icon: Icons.file_download_rounded,
    color: Color(0xFF3B82F6),
    category: ToolCategory.organize,
  ),
  ToolItem(
    id: 'rotate',
    title: 'Rotate',
    subtitle: 'Rotate pages to the right orientation.',
    icon: Icons.rotate_right_rounded,
    color: Color(0xFFF97316),
    category: ToolCategory.edit,
  ),
  ToolItem(
    id: 'protect',
    title: 'Protect',
    subtitle: 'Add password and encryption.',
    icon: Icons.shield_rounded,
    color: Color(0xFF6366F1),
    category: ToolCategory.security,
  ),
  ToolItem(
    id: 'convert',
    title: 'Convert',
    subtitle: 'Convert to/from PDF (Word, Excel, PPT, etc).',
    icon: Icons.swap_horiz_rounded,
    color: Color(0xFF14B8A6),
    category: ToolCategory.convert,
  ),
  ToolItem(
    id: 'watermark',
    title: 'Watermark',
    subtitle: 'Add text or image watermarks.',
    icon: Icons.water_drop_rounded,
    color: Color(0xFFEF4444),
    category: ToolCategory.edit,
  ),
  ToolItem(
    id: 'sign',
    title: 'Sign',
    subtitle: 'Add your digital signature.',
    icon: Icons.draw_rounded,
    color: Color(0xFFA855F7),
    category: ToolCategory.edit,
  ),
  ToolItem(
    id: 'searchable',
    title: 'Searchable',
    subtitle: 'Make your PDF searchable.',
    icon: Icons.manage_search_rounded,
    color: Color(0xFF0EA5E9),
    category: ToolCategory.edit,
  ),
];

class ToolSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final toolSearchQueryProvider = NotifierProvider<ToolSearchQuery, String>(ToolSearchQuery.new);

class ToolCategoryFilterNotifier extends Notifier<ToolCategoryFilter> {
  @override
  ToolCategoryFilter build() => ToolCategoryFilter.all;

  void select(ToolCategoryFilter value) => state = value;
}

final toolCategoryFilterProvider =
    NotifierProvider<ToolCategoryFilterNotifier, ToolCategoryFilter>(ToolCategoryFilterNotifier.new);

/// [kToolCatalog], filtered by the selected category and search text.
final filteredToolsProvider = Provider<List<ToolItem>>((ref) {
  final query = ref.watch(toolSearchQueryProvider).trim().toLowerCase();
  final category = ref.watch(toolCategoryFilterProvider);

  return kToolCatalog.where((tool) {
    final matchesCategory = switch (category) {
      ToolCategoryFilter.all => true,
      ToolCategoryFilter.edit => tool.category == ToolCategory.edit,
      ToolCategoryFilter.convert => tool.category == ToolCategory.convert,
      ToolCategoryFilter.organize => tool.category == ToolCategory.organize,
      ToolCategoryFilter.security => tool.category == ToolCategory.security,
    };
    final matchesQuery =
        query.isEmpty || tool.title.toLowerCase().contains(query) || tool.subtitle.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
});
