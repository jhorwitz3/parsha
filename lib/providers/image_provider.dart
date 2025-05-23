import 'package:parsha/models/parsha.dart';
import 'package:parsha/models/string_url_pair.dart';
import 'package:parsha/providers/parsha_provider.dart';

import 'package:riverpod/riverpod.dart';

final imageProvider = FutureProvider.autoDispose((ref) async {
  final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
  List<StringUrlPair> pairs = [];

  switch (parsha) {
    case AsyncData(:final value):
      pairs = getImageUrls(value);
  }
  return pairs;
});

List<StringUrlPair> getImageUrls(Parsha parsha) {
  List<StringUrlPair> pairs = [];
  pairs.add(parsha.summary);
  pairs += parsha.keyPoints;
  pairs += parsha.lessons;
  pairs += parsha.themes;
  return pairs;
}
