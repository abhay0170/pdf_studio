import 'package:flutter/material.dart';

/// What kind of content to pull out on the Extract PDF screen.
enum ExtractMode { images, pages, text, data }

extension ExtractModeX on ExtractMode {
  String get label => switch (this) {
    ExtractMode.images => 'Images',
    ExtractMode.pages => 'Pages',
    ExtractMode.text => 'Text',
    ExtractMode.data => 'Data',
  };

  String get subtitle => switch (this) {
    ExtractMode.images => 'Extract images',
    ExtractMode.pages => 'Extract pages',
    ExtractMode.text => 'Extract text',
    ExtractMode.data => 'Extract tables',
  };

  IconData get icon => switch (this) {
    ExtractMode.images => Icons.image_outlined,
    ExtractMode.pages => Icons.description_outlined,
    ExtractMode.text => Icons.text_snippet_outlined,
    ExtractMode.data => Icons.table_chart_outlined,
  };
}
