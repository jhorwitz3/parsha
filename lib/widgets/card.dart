import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/image_provider.dart';

class ParshaCard extends ConsumerWidget {
  const ParshaCard(
      {super.key,
      required this.category,
      required this.index,
      required this.indexLength,
      required this.text});
  final String category;
  final int index;
  final int indexLength;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, String>> imageMap = ref.watch(imageProvider);
    String key = category == 'Summary' ? 'image' : text;

    switch (imageMap) {
      case AsyncData(:final value):
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Text('$index/$indexLength',
                          style: Theme.of(context).textTheme.displayMedium)
                    ],
                  ),
                  //TODO replace with image
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.network(
                      value.containsKey(key) ? value[key]! : '',
                      height: 350,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        height: 350,
                        width: 350,
                        child: Container(
                            color: Colors.grey,
                            child: const Icon(Icons.question_mark)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      // Icon(
                      //   Icons.arrow_right,
                      //   color: Theme.of(context).colorScheme.primary,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      case AsyncError():
        return const Text('Oops, something unexpected happened');
      default:
        return const CircularProgressIndicator();
    }
  }
}
