import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Light and dark themes for the whole app. Screens should read colors and
/// text styles from `Theme.of(context)` / `context.appColors` rather than
/// hardcoding values.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.light.screenBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D5CFF)),
        extensions: const [AppColors.light],
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.dark.screenBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C9BFF),
          brightness: Brightness.dark,
        ),
        extensions: const [AppColors.dark],
      );
}
