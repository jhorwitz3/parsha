import 'package:flutter/material.dart';
import 'package:parsha/screens/characters.dart';
import 'package:parsha/screens/keys.dart';
import 'package:parsha/screens/summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
                icon: Icon(Icons.menu_book,
                    color: Theme.of(context).colorScheme.secondary)),
            Tab(
                icon: Icon(Icons.key,
                    color: Theme.of(context).colorScheme.secondary)),
            Tab(
                icon: Icon(Icons.people,
                    color: Theme.of(context).colorScheme.secondary)),
            Tab(
                icon: Icon(Icons.chat,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        body: TabBarView(
          children: [
            const SummaryScreen(),
            const KeyPointsScreen(),
            const CharacterScreen(),
            Center(
                child: Text('Coming soon!',
                    style: Theme.of(context).textTheme.displayMedium)),
          ],
        ),
      ),
    );
  }
}
