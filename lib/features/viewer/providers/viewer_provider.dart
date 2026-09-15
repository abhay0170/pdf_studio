import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Current page index of the document open in the viewer.
class CurrentPageNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setPage(int page) => state = page;
}

final currentPageProvider =
    NotifierProvider<CurrentPageNotifier, int>(CurrentPageNotifier.new);
