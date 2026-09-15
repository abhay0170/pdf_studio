import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/repositories/document_repository.dart';
import '../../../core/data/repositories/document_repository_local.dart';
import '../models/document_model.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepositoryLocal();
});

final documentsProvider = FutureProvider<List<DocumentModel>>((ref) {
  return ref.watch(documentRepositoryProvider).getDocuments();
});
