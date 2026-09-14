import 'package:firebase_auth/firebase_auth.dart';

import 'sign_in_with_phone_stub.dart'
    if (dart.library.html) 'sign_in_with_phone_web.dart'
    if (dart.library.io) 'sign_in_with_phone_mobile.dart' as sign_in_with_phone;

extension SignInWithPhoneFirebaseAuthExt on FirebaseAuth {
  Future<PhoneAuthCredential> startSignInWithPhone({
    required String phoneNumber,
    required String dialCode,
    Duration timeout = const Duration(minutes: 1),
  }) async {
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }

    return await sign_in_with_phone.startSignInWithPhone(
      firebaseAuth: this,
      phoneNumber: "$dialCode$phoneNumber",
      timeout: timeout,
    );
  }
}
