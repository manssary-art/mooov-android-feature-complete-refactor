import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

Future<PhoneAuthCredential> startSignInWithPhone({
  required FirebaseAuth firebaseAuth,
  required String phoneNumber,
  Duration timeout = const Duration(minutes: 1),
}) async {
  final completer = Completer<dynamic>();
  firebaseAuth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: timeout,
    verificationCompleted: (credentials) {
      if (completer.isCompleted) {
        return;
      }
      completer.complete(credentials);
    },
    verificationFailed: (exception) async {
      if (completer.isCompleted) {
        return;
      }
      completer.complete(exception);
    },
    codeSent: (verification, [id]) {
      if (completer.isCompleted) {
        return;
      }
      completer.complete(verification);
    },
    codeAutoRetrievalTimeout: (verification) {
      if (completer.isCompleted) {
        return;
      }

      completer.complete(TimeoutException('codeAutoRetrievalTimeout', timeout));
    },
  );

  final value = await completer.future;

  if (value is String) {
    return PhoneAuthProvider.credential(verificationId: value, smsCode: '');
  }

  if (value is PhoneAuthCredential) {
    return value;
  }

  if (value is Exception) {
    throw value;
  } else {
    throw AssertionError();
  }
}
