import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/string_url_name_triplet.dart';
import 'package:parsha/providers/favorite_provider.dart';
import 'package:parsha/widgets/card.dart';
import 'package:share_plus/share_plus.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard(
      {super.key,
      required this.category,
      required this.items,
      required this.aspectRatio,
      required this.tabControllerCallback});
  final List<StringUrlNameTriplet> items;
  final String category;
  final double aspectRatio;
  final void Function() tabControllerCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          CarouselWidget(
            category: category,
            items: items,
            aspectRatio: aspectRatio,
            tabControllerCallback: tabControllerCallback,
          )
        ]),
      ),
    );
  }
}

class CarouselWidget extends ConsumerStatefulWidget {
  const CarouselWidget(
      {super.key,
      required this.category,
      required this.items,
      required this.aspectRatio,
      required this.tabControllerCallback});

  final List<StringUrlNameTriplet> items;
  final String category;
  final double aspectRatio;
  final void Function() tabControllerCallback;

  @override
  ConsumerState<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends ConsumerState<CarouselWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List<ParshaCardContent> _buildCards() {
    List<ParshaCardContent> cards =
        widget.items.map((item) => ParshaCardContent(url: item.url, text: item.string)).toList();
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<ParshaCardContent> cards = _buildCards();
    List<StringUrlNameTriplet> favorites = ref.watch(favoritesProvider);
    debugPrint('favorites: ${favorites.length}');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.category,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              IconButton(
                  onPressed: () => SharePlus.instance.share(ShareParams(
                      title: cards[_current].text,
                      subject: cards[_current].text,
                      uri: Uri.tryParse(cards[_current].url))),
                  icon: Icon(
                    Icons.ios_share,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              IconButton(
                  onPressed: () async {
                    await ref.read(updateFavoritesProvider.notifier).writeStringUrlPair(widget.items[_current]);
                    // if (context.mounted) {
                    //   Navigator.of(context).pushNamed('/favorites');
                    // }
                    widget.tabControllerCallback.call();
                  },
                  icon: Icon(
                    widget.items.isEmpty || !favorites.contains(widget.items[_current])
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: Theme.of(context).colorScheme.primary,
                  ))
            ],
          ),
        ),
        CarouselSlider(
          items: cards,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              aspectRatio: widget.aspectRatio,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cards.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
