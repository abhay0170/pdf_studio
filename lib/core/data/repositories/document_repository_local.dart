import '../../../features/documents/models/document_model.dart';
import 'document_repository.dart';

/// Local-device implementation of [DocumentRepository].
///
/// Not wired to real storage yet — that lands with the rest of the
/// documents feature. For now it reports an empty library so the app runs.
class DocumentRepositoryLocal implements DocumentRepository {
  @override
  Future<List<DocumentModel>> getDocuments() async => const [];

  @override
  Future<DocumentModel> importDocument(String sourcePath) {
    throw UnimplementedError();
  }

  @override
  Future<void> renameDocument(String id, String newName) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDocument(String id) {
    throw UnimplementedError();
  }
}
