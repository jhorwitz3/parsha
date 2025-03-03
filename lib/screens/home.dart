import 'package:flutter/material.dart';
import 'package:parsha/screens/characters.dart';
import 'package:parsha/screens/description.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.menu_book, color: Theme.of(context).colorScheme.secondary)),
              Tab(icon: Icon(Icons.people, color: Theme.of(context).colorScheme.secondary)),
              Tab(icon: Icon(Icons.chat, color: Theme.of(context).colorScheme.secondary)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const DescriptionScreen(),
            const CharacterScreen(),
            Center(child: Text('Coming soon!', style: Theme.of(context).textTheme.displayMedium)),
          ],
        ),
      ),
    );
  }
}
