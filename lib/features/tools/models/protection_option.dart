import 'package:flutter/material.dart';

/// The four safeguards offered on the Protect PDF screen.
enum ProtectionOption { passwordProtect, restrictEditing, restrictPrinting, restrictCopying }

extension ProtectionOptionX on ProtectionOption {
  IconData get icon => switch (this) {
    ProtectionOption.passwordProtect => Icons.lock_rounded,
    ProtectionOption.restrictEditing => Icons.visibility_off_rounded,
    ProtectionOption.restrictPrinting => Icons.print_disabled_rounded,
    ProtectionOption.restrictCopying => Icons.insert_drive_file_outlined,
  };

  String get label => switch (this) {
    ProtectionOption.passwordProtect => 'Password Protect',
    ProtectionOption.restrictEditing => 'Restrict Editing',
    ProtectionOption.restrictPrinting => 'Restrict Printing',
    ProtectionOption.restrictCopying => 'Restrict Copying',
  };

  String get subtitle => switch (this) {
    ProtectionOption.passwordProtect => '(Recommended)',
    ProtectionOption.restrictEditing => 'Prevent changes',
    ProtectionOption.restrictPrinting => 'No printing',
    ProtectionOption.restrictCopying => 'No copying',
  };
}
