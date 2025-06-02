import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ));
  }
}
