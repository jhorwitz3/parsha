import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/carousel.dart';
import 'package:parsha/widgets/skeleton.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen(
      {super.key, required this.tabController, required this.tabIndex});
  final TabController tabController;
  final int tabIndex;

  List<StringUrlNameTriplet> pairToTriplet(
      List<StringUrlNameTriplet> pairs, String parshaName) {
    return pairs
        .map((pair) => StringUrlNameTriplet(
            string: pair.string, url: pair.url, name: parshaName))
        .toList();
  }

  List<CarouselCard> _buildSlidersFromData(
      Parsha parsha, List<StringUrlNameTriplet> favorites) {
    List<CarouselCard> sliders = [];

    //summary
    sliders.add(CarouselCard(
        category: 'Summary',
        items: pairToTriplet([parsha.summary], parsha.name),
        aspectRatio: 0.5));

    //key points
    sliders.add(
      CarouselCard(
          category: 'Key Points',
          items: pairToTriplet(parsha.keyPoints, parsha.name),
          aspectRatio: 0.8),
    );

    //lessons
    sliders.add(
      CarouselCard(
          category: 'Lessons',
          items: pairToTriplet(parsha.lessons, parsha.name),
          aspectRatio: 0.8),
    );

    //themes
    sliders.add(
      CarouselCard(
          category: 'Themes',
          items: pairToTriplet(parsha.themes, parsha.name),
          aspectRatio: 0.8),
    );

    return sliders;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
    final List<StringUrlNameTriplet> favorites = ref.watch(favoritesProvider);
    switch (parsha) {
      case AsyncData(:final value):
        List<CarouselCard> cards = _buildSlidersFromData(value, favorites);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cards,
            ),
          ),
        );
      case AsyncError():
        return const Text('Oops, something unexpected happened');
      default:
        return const SkeletonCard();
    }
  }
}
