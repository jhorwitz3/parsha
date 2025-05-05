import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  const UnorderedList({super.key, required this.texts, this.light = false});
  final List<String> texts;
  final bool light;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (final String text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(
        text: text,
        light: light,
      ));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem({super.key, required this.text, this.light = false});
  final String text;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Theme.of(context).colorScheme.surface)),
            ),
          ],
        ),
      ),
    );
  }
}
