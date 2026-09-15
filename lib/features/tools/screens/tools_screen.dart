import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routing/app_router.dart';
import '../../../app/theme/app_colors.dart';
import '../providers/tools_provider.dart';
import '../widgets/pro_banner.dart';
import '../widgets/tool_card.dart';
import '../widgets/tool_category_chips.dart';
import '../widgets/tool_search_bar.dart';
import '../widgets/tools_header.dart';

/// The Tools tab: search, filter and launch every PDF tool.
class ToolsScreen extends ConsumerStatefulWidget {
  const ToolsScreen({super.key});

  @override
  ConsumerState<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends ConsumerState<ToolsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    final tools = ref.watch(filteredToolsProvider);
    final category = ref.watch(toolCategoryFilterProvider);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToolsHeader(onPremiumTap: () => _showComingSoon('Premium coming soon')),
                  const SizedBox(height: 18),
                  ToolSearchBar(
                    controller: _searchController,
                    onChanged: (value) => ref.read(toolSearchQueryProvider.notifier).update(value),
                  ),
                  const SizedBox(height: 14),
                  ToolCategoryChips(
                    selected: category,
                    onSelected: (value) => ref.read(toolCategoryFilterProvider.notifier).select(value),
                  ),
                ],
              ),
            ),
            Expanded(
              child: tools.isEmpty
                  ? const _EmptyTools()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 110),
                      itemCount: tools.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.92,
                      ),
                      itemBuilder: (context, index) {
                        final tool = tools[index];
                        return ToolCard(
                          tool: tool,
                          onTap: switch (tool.id) {
                            'merge' => () => Navigator.of(context).pushNamed(AppRoutes.mergePdf),
                            'split' => () => Navigator.of(context).pushNamed(AppRoutes.splitPdf),
                            'compress' => () => Navigator.of(context).pushNamed(AppRoutes.compressPdf),
                            'extract' => () => Navigator.of(context).pushNamed(AppRoutes.extractPdf),
                            'rotate' => () => Navigator.of(context).pushNamed(AppRoutes.rotatePdf),
                            'protect' => () => Navigator.of(context).pushNamed(AppRoutes.protectPdf),
                            _ => () => _showComingSoon('${tool.title} coming soon'),
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 16,
          child: ProBanner(onTap: () => _showComingSoon('Premium coming soon')),
        ),
      ],
    );
  }
}

class _EmptyTools extends StatelessWidget {
  const _EmptyTools();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text('No tools found', style: TextStyle(color: colors.docMeta)),
      ),
    );
  }
}
