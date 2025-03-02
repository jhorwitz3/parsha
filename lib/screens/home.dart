import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
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
            Center(child: Text('Description', style: Theme.of(context).textTheme.displayMedium)),
            Center(child: Text('Characters', style: Theme.of(context).textTheme.displayMedium)),
            Center(child: Text('Commentary', style: Theme.of(context).textTheme.displayMedium)),
          ],
        ),
      ),
    );
  }
}
