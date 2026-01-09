import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/carousel.dart';
import 'package:parsha/widgets/skeleton.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key, required this.tabControllerCallback});
  final void Function() tabControllerCallback;

  List<StringUrlNameTriplet> pairToTriplet(List<StringUrlNameTriplet> pairs, String parshaName) {
    return pairs.map((pair) => StringUrlNameTriplet(string: pair.string, url: pair.url, name: parshaName)).toList();
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
    switch (parsha) {
      case AsyncData(:final value):


        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselCard(
                category: 'Summary',
                items: pairToTriplet([value.summary], value.name),
                aspectRatio: 0.5,
                tabControllerCallback: tabControllerCallback,
              )],
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
