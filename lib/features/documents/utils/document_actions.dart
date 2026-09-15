import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';

/// Launches the OS's native document scanner — ML Kit's GmsDocumentScanner
/// on Android, VNDocumentCameraViewController on iOS — for real-time edge
/// detection, auto-capture and perspective correction. Shows a confirmation
/// snackbar once pages are captured.
Future<void> openScanner(BuildContext context) async {
  List<String>? imagePaths;
  try {
    imagePaths = await CunningDocumentScanner.getPictures(
      scannerSource: ScannerSource.camera,
      noOfPages: 100,
    );
  } on CunningDocumentScannerException catch (e) {
    if (!context.mounted) return;
    _showMessage(context, e.message);
    return;
  }

  if (imagePaths == null) {
    // User cancelled — the plugin normalizes cancellation to null on every
    // platform, so there is nothing to clean up.
    return;
  }

  // Saving scanned pages into the document library is a later step, once
  // local storage is wired up — for now just confirm the capture.
  if (context.mounted) {
    final pageWord = imagePaths.length == 1 ? 'page' : 'pages';
    _showMessage(context, 'Scanned ${imagePaths.length} $pageWord');
  }

  await CunningDocumentScanner.cleanCache();
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}
