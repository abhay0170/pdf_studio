import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
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
          const SizedBox(height: 18),
          if (tools.isEmpty)
            const _EmptyTools()
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tools.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final tool = tools[index];
                return ToolCard(
                  tool: tool,
                  onTap: () => _showComingSoon('${tool.title} coming soon'),
                );
              },
            ),
          const SizedBox(height: 20),
          ProBanner(onTap: () => _showComingSoon('Premium coming soon')),
        ],
      ),
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
