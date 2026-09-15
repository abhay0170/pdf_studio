import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routing/app_router.dart';
import '../../../app/theme/app_colors.dart';
import '../models/document_model.dart';
import '../providers/documents_filter_provider.dart';
import '../providers/documents_provider.dart';
import '../widgets/document_card.dart';
import '../widgets/document_category_chips.dart';
import '../widgets/document_search_bar.dart';
import '../widgets/document_sort_header.dart';
import '../widgets/documents_empty_state.dart';
import '../widgets/documents_header.dart';
import '../widgets/scan_fab_button.dart';

/// The Documents tab: search, filter, sort and manage the full PDF library.
class DocumentsScreen extends ConsumerStatefulWidget {
  const DocumentsScreen({super.key});

  @override
  ConsumerState<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends ConsumerState<DocumentsScreen> {
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

  void _openDocument(DocumentModel document) {
    Navigator.of(context).pushNamed(AppRoutes.viewer, arguments: document);
  }

  void _showDocumentActions(DocumentModel document) {
    final colors = context.appColors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.screenBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.cardSubtitleMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 6),
              _ActionTile(
                icon: Icons.open_in_new_rounded,
                label: 'Open',
                onTap: () {
                  Navigator.pop(sheetContext);
                  _openDocument(document);
                },
              ),
              _ActionTile(
                icon: Icons.ios_share_rounded,
                label: 'Share',
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showComingSoon('Sharing coming soon');
                },
              ),
              _ActionTile(
                icon: Icons.edit_rounded,
                label: 'Rename',
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showComingSoon('Renaming coming soon');
                },
              ),
              _ActionTile(
                icon: Icons.drive_file_move_rounded,
                label: 'Move',
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showComingSoon('Moving coming soon');
                },
              ),
              _ActionTile(
                icon: Icons.copy_rounded,
                label: 'Duplicate',
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showComingSoon('Duplicating coming soon');
                },
              ),
              _ActionTile(
                icon: Icons.delete_rounded,
                label: 'Delete',
                destructive: true,
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showComingSoon('Deleting coming soon');
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty(AsyncValue<List<DocumentModel>> rawAsync, String query, DocumentCategoryFilter category) {
    if (query.isNotEmpty) {
      return const DocumentsEmptyState(
        icon: Icons.search_off_rounded,
        title: 'No documents found',
        message: 'Try a different search',
      );
    }

    final hasAnyDocuments = rawAsync.maybeWhen(data: (docs) => docs.isNotEmpty, orElse: () => false);
    if (hasAnyDocuments && category != DocumentCategoryFilter.all) {
      final label = switch (category) {
        DocumentCategoryFilter.scans => 'scanned',
        DocumentCategoryFilter.imported => 'imported',
        DocumentCategoryFilter.shared => 'shared',
        DocumentCategoryFilter.all => '',
      };
      return DocumentsEmptyState(
        icon: Icons.folder_open_rounded,
        title: 'No $label documents',
        message: 'Documents in this category will appear here.',
      );
    }

    return const DocumentsEmptyState(
      icon: Icons.description_outlined,
      title: 'No documents yet',
      message: 'Scan or import a file to get started.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final documentsAsync = ref.watch(filteredDocumentsProvider);
    final rawDocumentsAsync = ref.watch(documentsProvider);
    final category = ref.watch(documentCategoryFilterProvider);
    final sort = ref.watch(documentSortOptionProvider);
    final query = ref.watch(documentSearchQueryProvider);

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
                  DocumentsHeader(onPremiumTap: () => _showComingSoon('Premium coming soon')),
                  const SizedBox(height: 18),
                  DocumentSearchBar(
                    controller: _searchController,
                    onChanged: (value) => ref.read(documentSearchQueryProvider.notifier).update(value),
                  ),
                  const SizedBox(height: 14),
                  DocumentCategoryChips(
                    selected: category,
                    onSelected: (value) => ref.read(documentCategoryFilterProvider.notifier).select(value),
                  ),
                  const SizedBox(height: 10),
                  DocumentSortHeader(
                    selected: sort,
                    onSelected: (value) => ref.read(documentSortOptionProvider.notifier).select(value),
                  ),
                ],
              ),
            ),
            Expanded(
              child: documentsAsync.when(
                data: (docs) {
                  if (docs.isEmpty) {
                    return _buildEmpty(rawDocumentsAsync, query, category);
                  }
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: ListView.separated(
                      key: ValueKey('${category.name}-${sort.name}-$query'),
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 120),
                      itemCount: docs.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        return DocumentCard(
                          document: doc,
                          onTap: () => _openDocument(doc),
                          onMore: () => _showDocumentActions(doc),
                          onShare: () => _showComingSoon('Sharing coming soon'),
                          onRename: () => _showComingSoon('Renaming coming soon'),
                          onDelete: () => _showComingSoon('Deleting coming soon'),
                        );
                      },
                    ),
                  );
                },
                loading: () => const _DocumentsSkeleton(),
                error: (error, stackTrace) => _DocumentsError(onRetry: () => ref.invalidate(documentsProvider)),
              ),
            ),
          ],
        ),
        Positioned(
          right: 24,
          bottom: 20,
          child: ScanFabButton(onTap: () => _showComingSoon('Scanner coming soon')),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, required this.onTap, this.destructive = false});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = destructive ? colors.destructive : colors.cardTitle;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: color)),
      onTap: onTap,
    );
  }
}

class _DocumentsSkeleton extends StatelessWidget {
  const _DocumentsSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 120),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Container(
        height: 90,
        decoration: BoxDecoration(color: colors.docCardBackground, borderRadius: BorderRadius.circular(19)),
      ),
    );
  }
}

class _DocumentsError extends StatelessWidget {
  const _DocumentsError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: colors.destructive, size: 28),
          const SizedBox(height: 10),
          Text('Something went wrong', style: TextStyle(color: colors.cardTitle, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
