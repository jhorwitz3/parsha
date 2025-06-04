import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_name_triplet.dart';

class SingleFavoriteNotifier extends Notifier<StringUrlNameTriplet> {
  @override
  StringUrlNameTriplet build() {
    return const StringUrlNameTriplet(string: '', url: '', name: '');
  }

  void set(StringUrlNameTriplet val) => state = val;
}

final singleFavoriteProvider =
    NotifierProvider<SingleFavoriteNotifier, StringUrlNameTriplet>(() {
  return SingleFavoriteNotifier();
});
