import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/image_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, String>> imageMap = ref.watch(imageProvider);

    return switch (imageMap) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: value.values
                  .map((url) => Skeletonizer.zone(
                        child: Image.network(
                          url,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Bone(
                              height: 300,
                              width: 350,
                            );
                          },
                        ),
                      ))
                  .toList()),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => const CircularProgressIndicator(),
    };
  }
}
