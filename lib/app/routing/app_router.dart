import 'package:flutter/material.dart';

import '../../features/documents/models/document_model.dart';
import '../../features/tools/screens/compress_pdf_screen.dart';
import '../../features/tools/screens/extract_pdf_screen.dart';
import '../../features/tools/screens/merge_pdf_screen.dart';
import '../../features/tools/screens/protect_pdf_screen.dart';
import '../../features/tools/screens/rotate_pdf_screen.dart';
import '../../features/tools/screens/split_pdf_screen.dart';
import '../../features/viewer/screens/viewer_screen.dart';
import '../shell/main_shell.dart';

/// Every route in the app, listed in one place.
class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const viewer = '/viewer';
  static const mergePdf = '/tools/merge';
  static const splitPdf = '/tools/split';
  static const compressPdf = '/tools/compress';
  static const extractPdf = '/tools/extract';
  static const rotatePdf = '/tools/rotate';
  static const protectPdf = '/tools/protect';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.viewer:
      final document = settings.arguments as DocumentModel;
      return MaterialPageRoute(builder: (_) => ViewerScreen(document: document));
    case AppRoutes.mergePdf:
      return MaterialPageRoute(builder: (_) => const MergePdfScreen());
    case AppRoutes.splitPdf:
      return MaterialPageRoute(builder: (_) => const SplitPdfScreen());
    case AppRoutes.compressPdf:
      return MaterialPageRoute(builder: (_) => const CompressPdfScreen());
    case AppRoutes.extractPdf:
      return MaterialPageRoute(builder: (_) => const ExtractPdfScreen());
    case AppRoutes.rotatePdf:
      return MaterialPageRoute(builder: (_) => const RotatePdfScreen());
    case AppRoutes.protectPdf:
      return MaterialPageRoute(builder: (_) => const ProtectPdfScreen());
    case AppRoutes.home:
    default:
      return MaterialPageRoute(builder: (_) => const MainShell());
  }
}
