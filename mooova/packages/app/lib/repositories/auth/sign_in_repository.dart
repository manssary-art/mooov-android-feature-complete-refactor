import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class SignInRepository {
  Future<Result<PhoneAuthCredential>> startSignInWithPhone({
    required String phoneNumber,
    required Country country,
  });

  Future<Result<void>> completeSignInWithPhone({
    required String smsCode,
    required PhoneAuthCredential credential,
  });
}
