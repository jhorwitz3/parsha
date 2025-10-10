import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/card.dart';
import 'package:parsha/widgets/skeleton.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key, required this.tabControllerCallback});
  final void Function() tabControllerCallback;

  List<ParshaCard> _buildCards(
      Parsha parsha, List<StringUrlNameTriplet> favorites) {
    List<ParshaCard> cards = [];

    //summary
    cards.add(ParshaCard(
      url: parsha.summary.url,
      text: parsha.summary.string,
    ));

    //key points
    if (parsha.keyPoints.isNotEmpty) {
      for (StringUrlNameTriplet keyPoint in parsha.keyPoints) {
        cards.add(
          ParshaCard(
            url: keyPoint.url,
            text: keyPoint.string,
          ),
        );
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
    final List<StringUrlNameTriplet> favorites = ref.watch(favoritesProvider);
    switch (parsha) {
      case AsyncData(:final value):
        List<ParshaCard> cards = _buildCards(value, favorites);

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
