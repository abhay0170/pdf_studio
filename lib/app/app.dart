import 'package:flutter/material.dart';

import 'routing/app_router.dart';
import 'theme/app_theme.dart';

class PdfStudioApp extends StatelessWidget {
  const PdfStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Studio',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppRoutes.home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
