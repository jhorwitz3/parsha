import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/widgets/list.dart';
import 'package:parsha/widgets/text.dart';

class KeyPointsScreen extends ConsumerWidget {
  const KeyPointsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return switch (parsha) {
      AsyncData(:final value) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenTitle(title: 'Key Points'),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: UnorderedList(
                  texts: value.keyPoints,
                  light: true,
                ),
              ),
            ],
          ),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
