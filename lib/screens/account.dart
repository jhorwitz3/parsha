import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/user_provider.dart';
import 'package:parsha/widgets/button.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});
  String formatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Check if we have exactly 11 digits (1 + 10 digit US number)
    if (digits.length == 11 && digits.startsWith('1')) {
      // Remove the leading '1' for US numbers
      digits = digits.substring(1);
    }

    // Check if we have exactly 10 digits
    if (digits.length != 10) {
      return '';
    }

    // Extract area code, exchange, and number
    String areaCode = digits.substring(0, 3);
    String exchange = digits.substring(3, 6);
    String number = digits.substring(6, 10);

    // Format as (XXX)XXX-XXXX
    return '($areaCode) $exchange-$number';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAuthenticated = ref.watch(isAuthenticatedProvider);
    User? user = ref.watch(currentUserProvider);
    String displayPhoneNumber = formatPhoneNumber(user?.phoneNumber ?? '');

    if (!isAuthenticated) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Login or create an account to view profile settings',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            ColoredButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.of(context).pushNamed('/phone');
                })
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Hi!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "You're signed in as $displayPhoneNumber",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Hang out!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Or...",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ColoredButton(
                text: 'Sign Out',
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Sign Out?', style: Theme.of(context).textTheme.displayLarge),
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
              ),
            ),
            ColoredButton(
              text: 'Delete Account',
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Delete Account?', style: Theme.of(context).textTheme.displayLarge),
                        content: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("To delete account, sign out and sign back in. Then press 'Yes'.",
                                  style: Theme.of(context).textTheme.displayMedium),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: ColoredButton(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    onPressed: () async {
                                      try {
                                        await user?.delete();
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      } catch (e) {
                                        if (e.toString().contains('requires recent') && context.mounted) {
                                          debugPrint('gotcha');
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Unable to delete account. Please sign out and sign back into to proceed with account deletion.')));
                                        }
                                        debugPrint('exception: ${e.toString()}');
                                      }
                                    },
                                    text: 'Yes'),
                              ),
                              ColoredButton(
                                onPressed: () => Navigator.of(context).pop(),
                                text: 'Cancel',
                                backgroundColor: Colors.white,
                                foregroundColor: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
