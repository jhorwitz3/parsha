import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer.zone(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Bone(
            height: 300,
            width: 350,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
        ],
      ),
    ));
  }
}
