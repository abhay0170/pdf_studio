import 'package:flutter/material.dart';

/// The four rotation choices on the Rotate PDF screen.
enum RotateMode { clockwise90, counterclockwise90, rotate180, auto }

extension RotateModeX on RotateMode {
  IconData get icon => switch (this) {
    RotateMode.clockwise90 => Icons.rotate_right_rounded,
    RotateMode.counterclockwise90 => Icons.rotate_left_rounded,
    RotateMode.rotate180 => Icons.cached_rounded,
    RotateMode.auto => Icons.auto_fix_high_rounded,
  };

  String get label => switch (this) {
    RotateMode.clockwise90 => '90°',
    RotateMode.counterclockwise90 => '90°',
    RotateMode.rotate180 => '180°',
    RotateMode.auto => 'Auto',
  };

  String get subtitle => switch (this) {
    RotateMode.clockwise90 => 'Clockwise',
    RotateMode.counterclockwise90 => 'Counterclockwise',
    RotateMode.rotate180 => 'Rotate',
    RotateMode.auto => 'Auto detect',
  };
}
