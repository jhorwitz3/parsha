import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/card.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen(
      {super.key, required this.tabController, required this.tabIndex});
  final TabController tabController;
  final int tabIndex;

  List<ParshaCard> _buildFeedFromData(
      List<String> themes, List<String> lessons, List<String> keyPoints) {
    final lists = [themes, lessons, keyPoints];
    final categories = ['Themes', 'Lessons', 'Key Points'];

    int maxLength =
        lists.map((list) => list.length).reduce((a, b) => a > b ? a : b);
    List<ParshaCard> result = [];

    for (int i = 0; i < maxLength; i++) {
      for (int j = 0; j < lists.length; j++) {
        if (i < lists[j].length) {
          result.add(ParshaCard(
            category: categories[j],
            index: i + 1, // Using 1-based indexing
            indexLength: lists[j].length,
            text: lists[j][i],
          ));
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    switch (parsha) {
      case AsyncData(:final value):
        List<ParshaCard> cards =
            _buildFeedFromData(value.themes, value.lessons, value.keyPoints);

        //ensure summary appears first
        cards.insert(
            0,
            ParshaCard(
              category: 'Summary',
              index: 1,
              indexLength: 1,
              text: value.summary,
            ));
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
        return const CircularProgressIndicator();
    }
  }
}
