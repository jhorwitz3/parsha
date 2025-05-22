import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/image_provider.dart';
import 'package:parsha/widgets/card.dart';
import 'package:share_plus/share_plus.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard(
      {super.key,
      required this.category,
      required this.items,
      required this.aspectRatio});
  final List<String> items;
  final String category;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          CarouselWidget(
              category: category, items: items, aspectRatio: aspectRatio)
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
      required this.aspectRatio});

  final List<String> items;
  final String category;
  final double aspectRatio;

  @override
  ConsumerState<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends ConsumerState<CarouselWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List<ParshaCardContent> _buildCards() {
    List<ParshaCardContent> cards = widget.items
        .map((item) => ParshaCardContent(category: widget.category, text: item))
        .toList();
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<ParshaCardContent> cards = _buildCards();
    AsyncValue<Map<String, String>> imageMap = ref.watch(imageProvider);
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
                      uri: Uri.tryParse(imageMap.hasValue
                          ? imageMap.value![cards[_current].text] ?? ''
                          : ''))),
                  icon: Icon(
                    Icons.ios_share,
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
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
