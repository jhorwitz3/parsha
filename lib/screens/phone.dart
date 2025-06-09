import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/verification_id_provider.dart';

class PhoneNumberFormScreen extends ConsumerStatefulWidget {
  const PhoneNumberFormScreen({super.key});

  @override
  ConsumerState<PhoneNumberFormScreen> createState() => _PhoneNumberFormScreenState();
}

class _PhoneNumberFormScreenState extends ConsumerState<PhoneNumberFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }
    return null;
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+1 ${_phoneController.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            debugPrint('verification completed');

            setState(() {
              _isLoading = false;
            });
            // Sign the user in (or link) with the auto-generated credential
            await auth.signInWithCredential(credential);
            if (mounted) Navigator.of(context).popAndPushNamed('/home');
          },
          verificationFailed: (FirebaseAuthException e) {
            debugPrint('verification failed: $e');

            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: $e')),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            debugPrint('code sent');
            ref.read(verificationIdProvider.notifier).set(verificationId);

            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).popAndPushNamed('/code');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint('autoretrieval timeout');

            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Failed to retrieve code. ID: $verificationId')));
          },
        );
        debugPrint('Submitted phone number: ${_phoneController.text}');

        await Future.delayed(const Duration(seconds: 2));
      } catch (e) {
        debugPrint('failed with $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please enter your phone number',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Phone number input field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.labelMedium,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')),
                  ],
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    labelText: 'Phone Number',
                    hintText: '+1 (555) 123-4567',
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: _validatePhoneNumber,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onSubmit(),
                ),

                // Submit button
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 48, 8, 8),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const Spacer(),

                // Footer text
                Text(
                  'By submitting, you agree to receive SMS messages for verification purposes.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
