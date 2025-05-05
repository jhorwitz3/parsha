import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/list.dart';
import 'package:parsha/widgets/text.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return switch (parsha) {
      AsyncData(:final value) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenTitle(title: 'Summary'),
                UnorderedListItem(text: value.summary),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(16)),
                      onPressed: () {
                        debugPrint('Go to Key points');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
