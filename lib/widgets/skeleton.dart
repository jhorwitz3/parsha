import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
        child: Column(
      children: [
        SizedBox(
          height: 300,
          width: 350,
        )
      ],
    ));
  }
}
