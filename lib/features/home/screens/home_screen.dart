import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../documents/providers/documents_provider.dart';
import '../../documents/utils/document_actions.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/quick_action_pill.dart';
import '../widgets/recent_document_card.dart';

/// The Home tab: quick actions plus a preview of recent documents.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final documents = ref.watch(documentsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTopBar(
            onPremiumTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Premium coming soon'), behavior: SnackBarBehavior.floating),
                );
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: Icons.camera_alt_rounded,
                  title: 'Scan',
                  subtitle: 'Create PDF',
                  highlighted: true,
                  onTap: () => openScanner(context),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.photo_library_rounded,
                  title: 'Photos',
                  subtitle: 'Add images',
                  badgeBackground: colors.photosBadgeBackground,
                  badgeIconColor: colors.photosBadgeIcon,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: QuickActionPill(
                  icon: Icons.file_download_rounded,
                  iconColor: colors.importIcon,
                  label: 'Import',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: QuickActionPill(
                  icon: Icons.grid_view_rounded,
                  iconColor: colors.allToolsIcon,
                  label: 'All Tools',
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: colors.sectionTitle),
              ),
              Row(
                children: [
                  Text('See All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.seeAllLink)),
                  Icon(Icons.chevron_right_rounded, size: 18, color: colors.seeAllLink),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          documents.when(
            data: (docs) {
              if (docs.isEmpty) {
                return _EmptyRecentDocuments(colors: colors);
              }
              return Column(
                children: [
                  for (final doc in docs.take(5)) ...[
                    RecentDocumentCard(document: doc),
                    const SizedBox(height: 10),
                  ],
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => Text('$error', style: TextStyle(color: colors.docMeta)),
          ),
        ],
      ),
    );
  }
}

class _EmptyRecentDocuments extends StatelessWidget {
  const _EmptyRecentDocuments({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, color: colors.docMeta, size: 28),
            const SizedBox(height: 10),
            Text(
              'Your recent documents will show up here',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: colors.docMeta),
            ),
          ],
        ),
      ),
    );
  }
}
