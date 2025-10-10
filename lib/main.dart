import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';
import 'package:parsha/providers/user_provider.dart';
import 'package:parsha/routes.dart';
import 'package:parsha/style.dart';
import 'package:parsha/tools/time.dart';
import 'package:parsha/widgets/button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    name: 'Parsha',
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
      debugShowCheckedModeBanner: false,
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
    String todayDate = TimeTools().todayDate();
    return Scaffold(
      body: Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Theme.of(context).colorScheme.primary, // background gray
          highlightColor: Color.fromARGB(255, 161, 215, 240), // lighter shimmer
        ),
        enabled: parsha.isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(24, height / 3, 24, 0),
              child: Text(
                todayDate,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            switch (parsha) {
              AsyncData(:final value) => Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Text(
                    value.name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              AsyncError() => const Text('Oops, something unexpected happened'),
              _ => Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Bone.text(
                    style: Theme.of(context).textTheme.displayLarge,
                    words: 6,
                  ),
                ),
            },
            const Spacer(),
            const SignInButton()
          ],
        ),
      ),
    );
  }
}

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // User? user = ref.watch(currentUserProvider);
    // debugPrint('user: $user');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
      child: Center(
        child: ColoredButton(
            text: "Let's Go",
            onPressed: () {
              ref.invalidate(currentUserProvider);
              Navigator.of(context).pushNamed('/home');
            }),
      ),
    );
  }
}
