import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/carousel.dart';
import 'package:parsha/widgets/skeleton.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen(
      {super.key, required this.tabController, required this.tabIndex});
  final TabController tabController;
  final int tabIndex;

  List<CarouselWithIndicator> _buildSlidersFromData(Parsha parsha) {
    List<CarouselWithIndicator> sliders = [];

    //summary
    sliders.add(CarouselWithIndicator(
        category: 'Summary', items: [parsha.summary], aspectRatio: 0.6));

    //key points
    sliders.add(
      CarouselWithIndicator(
          category: 'Key Points', items: parsha.keyPoints, aspectRatio: 0.8),
    );

    //lessons
    sliders.add(
      CarouselWithIndicator(
          category: 'Lessons', items: parsha.lessons, aspectRatio: 0.8),
    );

    //themes
    sliders.add(
      CarouselWithIndicator(
          category: 'Themes', items: parsha.themes, aspectRatio: 0.8),
    );

    return sliders;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
    switch (parsha) {
      case AsyncData(:final value):
        List<CarouselWithIndicator> cards = _buildSlidersFromData(value);

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
