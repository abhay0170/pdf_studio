import 'package:flutter/material.dart';

import '../../features/documents/models/document_model.dart';
import '../../features/viewer/screens/viewer_screen.dart';
import '../shell/main_shell.dart';

/// Every route in the app, listed in one place.
class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const viewer = '/viewer';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.viewer:
      final document = settings.arguments as DocumentModel;
      return MaterialPageRoute(builder: (_) => ViewerScreen(document: document));
    case AppRoutes.home:
    default:
      return MaterialPageRoute(builder: (_) => const MainShell());
  }
}
