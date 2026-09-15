import 'package:flutter/material.dart';

import '../../documents/models/document_model.dart';

/// Opens a single document for reading. Page rendering is not wired up yet —
/// this is a placeholder until the PDF engine is chosen.
class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key, required this.document});

  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(document.name)),
      body: const Center(child: Text('Viewer coming soon')),
    );
  }
}
