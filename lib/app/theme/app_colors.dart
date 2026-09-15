import 'package:flutter/material.dart';

/// Design tokens for surfaces the standard Material [ColorScheme] doesn't
/// cover directly (badge tints, the scan gradient, nav bar states, ...).
/// Access via `context.appColors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.screenBackground,
    required this.titleAccent,
    required this.chipDark,
    required this.cardFlatBackground,
    required this.cardTitle,
    required this.cardSubtitleMuted,
    required this.scanGradient,
    required this.photosBadgeBackground,
    required this.photosBadgeIcon,
    required this.importIcon,
    required this.allToolsIcon,
    required this.sectionTitle,
    required this.seeAllLink,
    required this.docCardBackground,
    required this.docBadgeBackground,
    required this.docBadgeIcon,
    required this.docTitle,
    required this.docMeta,
    required this.navActive,
    required this.navInactive,
    required this.destructive,
  });

  final Color screenBackground;
  final Color titleAccent;

  /// Dark navy chip used for the avatar and the small circular arrow
  /// buttons — the same in both themes.
  final Color chipDark;

  final Color cardFlatBackground;
  final Color cardTitle;
  final Color cardSubtitleMuted;

  final Gradient scanGradient;

  final Color photosBadgeBackground;
  final Color photosBadgeIcon;

  final Color importIcon;
  final Color allToolsIcon;

  final Color sectionTitle;
  final Color seeAllLink;

  final Color docCardBackground;
  final Color docBadgeBackground;
  final Color docBadgeIcon;
  final Color docTitle;
  final Color docMeta;

  final Color navActive;
  final Color navInactive;

  /// Destructive/delete accent — red in both themes.
  final Color destructive;

  static const _scanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3D5CFF), Color(0xFF7C9BFF)],
  );

  static const light = AppColors(
    screenBackground: Color(0xFFFFFFFF),
    titleAccent: Color(0xFF3B5BDB),
    chipDark: Color(0xFF1F2230),
    cardFlatBackground: Color(0xFFF3F4F6),
    cardTitle: Color(0xFF16171F),
    cardSubtitleMuted: Color(0xFF9AA0AC),
    scanGradient: _scanGradient,
    photosBadgeBackground: Color(0xFFE7ECFF),
    photosBadgeIcon: Color(0xFF3D5CFF),
    importIcon: Color(0xFF16A34A),
    allToolsIcon: Color(0xFF7C3AED),
    sectionTitle: Color(0xFF1F2937),
    seeAllLink: Color(0xFF7C9BFF),
    docCardBackground: Color(0xFFF3F4F6),
    docBadgeBackground: Color(0xFFE7ECFF),
    docBadgeIcon: Color(0xFF3D5CFF),
    docTitle: Color(0xFF16171F),
    docMeta: Color(0xFF9AA0AC),
    navActive: Color(0xFF1B1E2C),
    navInactive: Color(0xFF6E7180),
    destructive: Color(0xFFEF4444),
  );

  static const dark = AppColors(
    screenBackground: Color(0xFF0B0C10),
    titleAccent: Color(0xFF7C9BFF),
    chipDark: Color(0xFF1F2230),
    cardFlatBackground: Color(0xFF16171F),
    cardTitle: Color(0xFFF5F6F8),
    cardSubtitleMuted: Color(0xFF9AA0AC),
    scanGradient: _scanGradient,
    photosBadgeBackground: Color(0xFF242A45),
    photosBadgeIcon: Color(0xFF7C9BFF),
    importIcon: Color(0xFF4ADE94),
    allToolsIcon: Color(0xFFB08CFF),
    sectionTitle: Color(0xFFF5F6F8),
    seeAllLink: Color(0xFF7C9BFF),
    docCardBackground: Color(0x1AFFFFFF),
    docBadgeBackground: Color(0xFF242A45),
    docBadgeIcon: Color(0xFF7C9BFF),
    docTitle: Color(0xFFF5F6F8),
    docMeta: Color(0xFF9AA0AC),
    navActive: Color(0xFFF5F6F8),
    navInactive: Color(0xFF6E7180),
    destructive: Color(0xFFFF4D55),
  );

  @override
  AppColors copyWith({
    Color? screenBackground,
    Color? titleAccent,
    Color? chipDark,
    Color? cardFlatBackground,
    Color? cardTitle,
    Color? cardSubtitleMuted,
    Gradient? scanGradient,
    Color? photosBadgeBackground,
    Color? photosBadgeIcon,
    Color? importIcon,
    Color? allToolsIcon,
    Color? sectionTitle,
    Color? seeAllLink,
    Color? docCardBackground,
    Color? docBadgeBackground,
    Color? docBadgeIcon,
    Color? docTitle,
    Color? docMeta,
    Color? navActive,
    Color? navInactive,
    Color? destructive,
  }) {
    return AppColors(
      screenBackground: screenBackground ?? this.screenBackground,
      titleAccent: titleAccent ?? this.titleAccent,
      chipDark: chipDark ?? this.chipDark,
      cardFlatBackground: cardFlatBackground ?? this.cardFlatBackground,
      cardTitle: cardTitle ?? this.cardTitle,
      cardSubtitleMuted: cardSubtitleMuted ?? this.cardSubtitleMuted,
      scanGradient: scanGradient ?? this.scanGradient,
      photosBadgeBackground: photosBadgeBackground ?? this.photosBadgeBackground,
      photosBadgeIcon: photosBadgeIcon ?? this.photosBadgeIcon,
      importIcon: importIcon ?? this.importIcon,
      allToolsIcon: allToolsIcon ?? this.allToolsIcon,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      seeAllLink: seeAllLink ?? this.seeAllLink,
      docCardBackground: docCardBackground ?? this.docCardBackground,
      docBadgeBackground: docBadgeBackground ?? this.docBadgeBackground,
      docBadgeIcon: docBadgeIcon ?? this.docBadgeIcon,
      docTitle: docTitle ?? this.docTitle,
      docMeta: docMeta ?? this.docMeta,
      navActive: navActive ?? this.navActive,
      navInactive: navInactive ?? this.navInactive,
      destructive: destructive ?? this.destructive,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      screenBackground: Color.lerp(screenBackground, other.screenBackground, t)!,
      titleAccent: Color.lerp(titleAccent, other.titleAccent, t)!,
      chipDark: Color.lerp(chipDark, other.chipDark, t)!,
      cardFlatBackground: Color.lerp(cardFlatBackground, other.cardFlatBackground, t)!,
      cardTitle: Color.lerp(cardTitle, other.cardTitle, t)!,
      cardSubtitleMuted: Color.lerp(cardSubtitleMuted, other.cardSubtitleMuted, t)!,
      scanGradient: Gradient.lerp(scanGradient, other.scanGradient, t)!,
      photosBadgeBackground: Color.lerp(photosBadgeBackground, other.photosBadgeBackground, t)!,
      photosBadgeIcon: Color.lerp(photosBadgeIcon, other.photosBadgeIcon, t)!,
      importIcon: Color.lerp(importIcon, other.importIcon, t)!,
      allToolsIcon: Color.lerp(allToolsIcon, other.allToolsIcon, t)!,
      sectionTitle: Color.lerp(sectionTitle, other.sectionTitle, t)!,
      seeAllLink: Color.lerp(seeAllLink, other.seeAllLink, t)!,
      docCardBackground: Color.lerp(docCardBackground, other.docCardBackground, t)!,
      docBadgeBackground: Color.lerp(docBadgeBackground, other.docBadgeBackground, t)!,
      docBadgeIcon: Color.lerp(docBadgeIcon, other.docBadgeIcon, t)!,
      docTitle: Color.lerp(docTitle, other.docTitle, t)!,
      docMeta: Color.lerp(docMeta, other.docMeta, t)!,
      navActive: Color.lerp(navActive, other.navActive, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
