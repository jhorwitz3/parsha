import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardHeader extends ConsumerWidget {
  const CardHeader({super.key, required this.stringUrlNameTriplet});
  final StringUrlNameTriplet stringUrlNameTriplet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<StringUrlNameTriplet> favorites = ref.watch(favoritesProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // IconButton(
        //     onPressed: () => SharePlus.instance.share(ShareParams(
        //         title: stringUrlNameTriplet.string,
        //         subject: stringUrlNameTriplet.string,
        //         uri: Uri.tryParse(stringUrlNameTriplet.url))),
        //     icon: Icon(
        //       Icons.ios_share,
        //       color: Theme.of(context).colorScheme.primary,
        //     )),
        IconButton(
            onPressed: () async {
              await ref
                  .read(updateFavoritesProvider.notifier)
                  .writeStringUrlPair(stringUrlNameTriplet);
              // if (context.mounted) {
              //   Navigator.of(context).pushNamed('/favorites');
              // }
              // widget.tabControllerCallback.call();
            },
            icon: Icon(
              !favorites.contains(stringUrlNameTriplet)
                  ? Icons.favorite_border
                  : Icons.favorite,
              color: Theme.of(context).colorScheme.primary,
            ))
      ],
    );
  }
}

class ParshaCard extends ConsumerWidget {
  const ParshaCard(
      {super.key,
      required this.stringUrlNameTriplet,
      this.top = false,
      this.bottom = false});
  final StringUrlNameTriplet stringUrlNameTriplet;

  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Radius topCorner = top ? const Radius.circular(10) : Radius.zero;
    Radius bottomCorner = bottom ? const Radius.circular(10) : Radius.zero;

    bool isFavorite =
        ref.watch(favoritesProvider).contains(stringUrlNameTriplet);

    return GestureDetector(
      onDoubleTap: () => ref
          .read(updateFavoritesProvider.notifier)
          .writeStringUrlPair(stringUrlNameTriplet),
      child: Container(
          decoration: BoxDecoration(
              color: isFavorite
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.only(
                  topLeft: topCorner,
                  topRight: topCorner,
                  bottomLeft: bottomCorner,
                  bottomRight: bottomCorner),
              border: Border.all(color: Colors.white)),
          child: ParshaCardContent(stringUrlNameTriplet: stringUrlNameTriplet)),
    );
  }
}

class ParshaCardContent extends StatelessWidget {
  const ParshaCardContent({super.key, required this.stringUrlNameTriplet});
  final StringUrlNameTriplet stringUrlNameTriplet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          ImageWidget(
            url: stringUrlNameTriplet.url,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  stringUrlNameTriplet.string,
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
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key, required this.url, this.height = 300, this.width = 350});
  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Skeletonizer.zone(
          child: Image.network(
            url,
            height: height,
            width: width,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => SizedBox(
              height: height,
              width: width,
              child: Container(
                  color: Colors.grey, child: const Icon(Icons.question_mark)),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Bone(
                height: height,
                width: width,
              );
            },
          ),
        ),
      ),
    );
  }
}
