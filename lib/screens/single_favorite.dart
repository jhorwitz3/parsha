import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_pair.dart';
import 'package:parsha/providers/single_favorite_provider.dart';
import 'package:parsha/widgets/card.dart';

class SingleFavoriteScreen extends ConsumerWidget {
  const SingleFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StringUrlPair pair = ref.watch(singleFavoriteProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Center(
                child: ImageWidget(
              url: pair.url,
              height: 500,
              width: 400,
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                pair.string,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
