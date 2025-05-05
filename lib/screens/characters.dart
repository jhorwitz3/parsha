import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/list.dart';
import 'package:parsha/widgets/text.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return switch (parsha) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenTitle(title: 'Characters'),
              UnorderedList(
                  texts: value.characters.map((char) => char.name).toList()),
            ],
          ),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
