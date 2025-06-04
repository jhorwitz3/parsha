import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_pair.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:parsha/providers/single_favorite_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<StringUrlPair>> imageList =
        ref.watch(futureFavoritesProvider);

    return switch (imageList) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: value
                  .map((pair) => GridTile(
                        child: InkWell(
                          onTap: () {
                            debugPrint('tapped');
                            ref.read(singleFavoriteProvider.notifier).set(pair);
                            Navigator.of(context).pushNamed('/favorite');
                          },
                          child: Skeletonizer.zone(
                            child: Image.network(
                              pair.url,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Bone(
                                  height: 300,
                                  width: 350,
                                );
                              },
                            ),
                          ),
                        ),
                      ))
                  .toList()),
        ),
      AsyncError() => const Text('Oops, something unexpected happened'),
      _ => GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
              .map((url) => const Skeletonizer.zone(
                    child: Bone(
                      height: 300,
                      width: 350,
                    ),
                  ))
              .toList()),
    };
  }
}
