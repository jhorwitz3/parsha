import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/providers/tab_index_provider.dart';
import 'package:parsha/screens/favorites.dart';
import 'package:parsha/screens/summary.dart';
import 'package:parsha/widgets/button.dart';

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
    final int index = ref.watch(tabIndexProvider);
    return switch (parsha) {
      AsyncError() => const Text('Oops, something unexpected happened'),
      AsyncData(:final value) => DefaultTabController(
          initialIndex: index,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                value.name,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('Logout?', style: Theme.of(context).textTheme.displayMedium),
                              content: SizedBox(
                                height: 200,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: ColoredButton(
                                          onPressed: () async {
                                            FirebaseAuth auth = FirebaseAuth.instance;
                                            await auth.signOut();
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          text: 'Yes'),
                                    ),
                                    ColoredButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      text: 'Cancel',
                                      foregroundColor: Colors.white,
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                ),
                              ),
                            )),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
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
                  tabControllerCallback: () => setState(() {
                    tabController.index = 1;
                  }),
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
