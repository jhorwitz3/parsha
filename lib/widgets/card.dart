import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/image_provider.dart';
import 'package:parsha/widgets/skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ParshaCard extends ConsumerWidget {
  const ParshaCard({super.key, required this.category, required this.text});
  final String category;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, String>> imageMap = ref.watch(imageProvider);
    String key = category == 'Summary' ? 'image' : text;

    switch (imageMap) {
      case AsyncData(:final value):
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 16),
          child: Column(
            children: [
              //TODO replace with image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Skeletonizer.zone(
                    child: Image.network(
                      value.containsKey(key) ? value[key]! : '',
                      height: 300,
                      width: 350,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        height: 300,
                        width: 350,
                        child: Container(
                            color: Colors.grey,
                            child: const Icon(Icons.question_mark)),
                      ),
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
              )
            ],
          ),
        );
      case AsyncError():
        return const Text('Oops, something unexpected happened');
      default:
        return const SkeletonCard();
    }
  }
}
