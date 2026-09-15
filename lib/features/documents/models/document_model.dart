/// Where a document came from — drives the category filter chips.
enum DocumentCategory { scan, imported, shared }

/// A single PDF file in the user's library.
class DocumentModel {
  const DocumentModel({
    required this.id,
    required this.name,
    required this.path,
    required this.sizeBytes,
    required this.pageCount,
    required this.modifiedAt,
    this.category = DocumentCategory.imported,
  });

  final String id;
  final String name;
  final String path;
  final int sizeBytes;
  final int pageCount;
  final DateTime modifiedAt;
  final DocumentCategory category;
}
