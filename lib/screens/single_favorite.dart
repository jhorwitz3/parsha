import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:parsha/providers/single_favorite_provider.dart';
import 'package:parsha/widgets/card.dart';

class SingleFavoriteScreen extends ConsumerWidget {
  const SingleFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StringUrlNameTriplet triplet = ref.watch(singleFavoriteProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Center(
          child: Text(
            triplet.name ?? '',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        content: SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogButton(
                                text: 'Remove',
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                onPressed: () async {
                                  await ref
                                      .read(updateFavoritesProvider.notifier)
                                      .removeStringUrlPair(triplet);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              DialogButton(
                                text: 'Back',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Center(
                child: ImageWidget(
              url: triplet.url,
              height: 400,
              width: 400,
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  triplet.string,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.foregroundColor = Colors.black});
  final void Function() onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: foregroundColor),
              )),
        ),
      ],
    );
  }
}
