import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/screens/favorites.dart';
import 'package:parsha/screens/summary.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
    return switch (parsha) {
      AsyncError() => const Text('Oops, something unexpected happened'),
      AsyncData(:final value) => DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                value.name,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(icon: Icon(Icons.menu_book, color: Theme.of(context).colorScheme.secondary)),
                  Tab(icon: Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                SummaryScreen(
                  tabController: tabController,
                  tabIndex: 0,
                ),
                const FavoritesScreen(),
              ],
            ),
          ),
        ),
      _ => const CircularProgressIndicator(),
    };
  }
}
