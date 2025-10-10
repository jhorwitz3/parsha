import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ParshaCard extends StatelessWidget {
  const ParshaCard(
      {super.key,
      required this.url,
      required this.text,
      this.top = false,
      this.bottom = false});
  final String url;
  final String text;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    Radius topCorner = top ? const Radius.circular(10) : Radius.zero;
    Radius bottomCorner = bottom ? const Radius.circular(10) : Radius.zero;
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.only(
                topLeft: topCorner,
                topRight: topCorner,
                bottomLeft: bottomCorner,
                bottomRight: bottomCorner),
            border: Border.all(color: Colors.white)),
        child: ParshaCardContent(url: url, text: text));
  }
}

class ParshaCardContent extends StatelessWidget {
  const ParshaCardContent({super.key, required this.url, required this.text});
  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 16),
      child: Column(
        children: [
          ImageWidget(
            url: url,
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
