import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/routes.dart';
import 'package:parsha/style.dart';
import 'firebase_options.dart';
// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const MyHomePage(),
      routes: routes,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            switch (parsha) {
              AsyncData(:final value) => Padding(
                  padding: EdgeInsets.fromLTRB(24, height / 3, 24, height / 4),
                  child: Text(
                    'Parashat ${value.name}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              AsyncError() => const Text('Oops, something unexpected happened'),
              _ => const CircularProgressIndicator(),
            },
            ElevatedButton(
                // style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.of(context).pushNamed('/home'),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Learn More',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
