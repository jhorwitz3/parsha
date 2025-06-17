import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor = const Color(0xff086796),
  });

  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
