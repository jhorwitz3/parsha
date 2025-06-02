import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parsha/providers/verification_id_provider.dart';

class PhoneCodeFormScreen extends ConsumerStatefulWidget {
  const PhoneCodeFormScreen({super.key});

  @override
  ConsumerState<PhoneCodeFormScreen> createState() =>
      _PhoneCodeFormScreenState();
}

class _PhoneCodeFormScreenState extends ConsumerState<PhoneCodeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid code';
    }

    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length != 6) {
      return 'Code must be 6 digits';
    }
    return null;
  }

  Future<void> _submitCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = _codeController.text;
    String verificationId = ref.read(verificationIdProvider);

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      setState(() {
        _isLoading = false;
      });
      if (mounted) Navigator.of(context).popAndPushNamed('/home');
    } catch (e) {
      debugPrint('error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _submitCode();
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
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please enter the code you received',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Phone number input field
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.labelMedium,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9+\-\s\(\)]')),
                  ],
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    labelText: 'Code',
                    hintText: '123456',
                    prefixIcon: const Icon(
                      Icons.calculate,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white)),
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
                  validator: _validateCode,
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
