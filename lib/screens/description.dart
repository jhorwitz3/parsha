import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';

class DescriptionScreen extends ConsumerWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return switch (parsha) {
      AsyncData(:final value) => Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 72, 24, 24),
            child: SingleChildScrollView(
              child: Text(
                value.description,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
