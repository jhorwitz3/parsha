import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormScreen extends StatefulWidget {
  const PhoneNumberFormScreen({super.key});

  @override
  State<PhoneNumberFormScreen> createState() => _PhoneNumberFormScreenState();
}

class _PhoneNumberFormScreenState extends State<PhoneNumberFormScreen> {
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

      // Simulate API call or processing
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Handle successful submission
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Phone number submitted: ${_phoneController.text}'),
            backgroundColor: Colors.green,
          ),
        );
        // You can add your actual submission logic here
        debugPrint('Submitted phone number: ${_phoneController.text}');
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
                // Header text
                Text(
                  'Phone Number Verification',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please enter your phone number to continue',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Phone number input field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.labelMedium,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9+\-\s\(\)]')),
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
                            'Submit',
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
