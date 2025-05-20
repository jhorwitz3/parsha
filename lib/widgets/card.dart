import 'package:flutter/material.dart';

class ParshaCard extends StatelessWidget {
  const ParshaCard(
      {super.key,
      required this.category,
      required this.index,
      required this.indexLength,
      required this.text});
  final String category;
  final int index;
  final int indexLength;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Text('$index/$indexLength',
                    style: Theme.of(context).textTheme.displayMedium)
              ],
            ),
            //TODO replace with image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                height: 200,
                width: 350,
                child: Container(
                  color: Colors.green,
                  child: Center(child: Text("image goes here")),
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
