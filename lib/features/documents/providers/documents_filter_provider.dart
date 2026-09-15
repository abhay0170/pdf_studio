import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_model.dart';
import 'documents_provider.dart';

/// The four category chips on the Documents tab.
enum DocumentCategoryFilter { all, scans, imported, shared }

/// Options in the "Recent" sort menu.
enum DocumentSortOption { recent, oldest, nameAZ, nameZA, largest, smallest }

extension DocumentSortOptionLabel on DocumentSortOption {
  String get label => switch (this) {
        DocumentSortOption.recent => 'Recent',
        DocumentSortOption.oldest => 'Oldest',
        DocumentSortOption.nameAZ => 'Name A–Z',
        DocumentSortOption.nameZA => 'Name Z–A',
        DocumentSortOption.largest => 'Largest',
        DocumentSortOption.smallest => 'Smallest',
      };
}

class DocumentSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final documentSearchQueryProvider = NotifierProvider<DocumentSearchQuery, String>(DocumentSearchQuery.new);

class DocumentCategoryFilterNotifier extends Notifier<DocumentCategoryFilter> {
  @override
  DocumentCategoryFilter build() => DocumentCategoryFilter.all;

  void select(DocumentCategoryFilter value) => state = value;
}

final documentCategoryFilterProvider =
    NotifierProvider<DocumentCategoryFilterNotifier, DocumentCategoryFilter>(DocumentCategoryFilterNotifier.new);

class DocumentSortOptionNotifier extends Notifier<DocumentSortOption> {
  @override
  DocumentSortOption build() => DocumentSortOption.recent;

  void select(DocumentSortOption value) => state = value;
}

final documentSortOptionProvider =
    NotifierProvider<DocumentSortOptionNotifier, DocumentSortOption>(DocumentSortOptionNotifier.new);

/// [documentsProvider], filtered by category/search and sorted — what the
/// Documents list actually renders.
final filteredDocumentsProvider = Provider<AsyncValue<List<DocumentModel>>>((ref) {
  final documentsAsync = ref.watch(documentsProvider);
  final query = ref.watch(documentSearchQueryProvider).trim().toLowerCase();
  final category = ref.watch(documentCategoryFilterProvider);
  final sort = ref.watch(documentSortOptionProvider);

  return documentsAsync.whenData((docs) {
    final results = docs.where((doc) {
      final matchesCategory = switch (category) {
        DocumentCategoryFilter.all => true,
        DocumentCategoryFilter.scans => doc.category == DocumentCategory.scan,
        DocumentCategoryFilter.imported => doc.category == DocumentCategory.imported,
        DocumentCategoryFilter.shared => doc.category == DocumentCategory.shared,
      };
      final matchesQuery = query.isEmpty || doc.name.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    results.sort((a, b) => switch (sort) {
          DocumentSortOption.recent => b.modifiedAt.compareTo(a.modifiedAt),
          DocumentSortOption.oldest => a.modifiedAt.compareTo(b.modifiedAt),
          DocumentSortOption.nameAZ => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
          DocumentSortOption.nameZA => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
          DocumentSortOption.largest => b.sizeBytes.compareTo(a.sizeBytes),
          DocumentSortOption.smallest => a.sizeBytes.compareTo(b.sizeBytes),
        });

    return results;
  });
});
