import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  const UnorderedList({super.key, required this.texts, this.light = false});
  final List<String> texts;
  final bool light;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (final (int index, String text) in texts.indexed) {
      // Add list item
      widgetList.add(UnorderedListItem(
        index: index + 1,
        text: text,
        light: light,
      ));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(
      {super.key, required this.index, required this.text, this.light = false});
  final String text;
  final int index;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: light ? Colors.white : null,
      surfaceTintColor: light ? null : Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(text,
                  style: light
                      ? Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.surface)
                      : Theme.of(context).textTheme.displayMedium),
            ),
          ],
        ),
      ),
    );
  }
}
