import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_pair.dart';

class SingleFavoriteNotifier extends Notifier<StringUrlPair> {
  @override
  StringUrlPair build() {
    return const StringUrlPair(string: '', url: '');
  }

  void set(StringUrlPair val) => state = val;
}

final singleFavoriteProvider =
    NotifierProvider<SingleFavoriteNotifier, StringUrlPair>(() {
  return SingleFavoriteNotifier();
});
