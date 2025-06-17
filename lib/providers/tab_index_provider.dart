import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndexNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void set(int val) => state = val;
}

final tabIndexProvider = NotifierProvider<TabIndexNotifier, int>(() {
  return TabIndexNotifier();
});
