import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
