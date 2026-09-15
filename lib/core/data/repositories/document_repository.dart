import '../../../features/documents/models/document_model.dart';

/// Where documents come from. Today the only implementation is local device
/// storage ([DocumentRepositoryLocal]); a cloud-backed implementation can be
/// added later without changing anything that depends on this contract.
abstract class DocumentRepository {
  Future<List<DocumentModel>> getDocuments();

  Future<DocumentModel> importDocument(String sourcePath);

  Future<void> renameDocument(String id, String newName);

  Future<void> deleteDocument(String id);
}
