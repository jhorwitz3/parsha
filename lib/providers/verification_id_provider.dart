import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationIdNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void set(String val) => state = val;
}

final verificationIdProvider =
    NotifierProvider<VerificationIdNotifier, String>(() {
  return VerificationIdNotifier();
});
