import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 72, 24, 24),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 36),
      ),
    );
  }
}
