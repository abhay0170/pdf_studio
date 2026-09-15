import 'package:flutter/widgets.dart';

/// Anything that must run before the first screen shows.
Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();
}
