import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return switch (parsha) {
      AsyncData(:final value) => Container(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                    itemCount: value.characters.length,
                    itemBuilder: (BuildContext context, int index) => Card(
                          color: Theme.of(context).colorScheme.surface,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value.characters[index],
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ))),
          ),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
