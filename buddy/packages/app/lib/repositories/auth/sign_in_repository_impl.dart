import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firebase/firebase_auth/sign_in_with_phone.dart';
import '../exceptions/sign_in_exception.dart';
import 'sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final FirebaseAuth firebaseAuth;

  SignInRepositoryImpl({
    required this.firebaseAuth,
  });

  @override
  Future<Result<void>> completeSignInWithPhone({
    required String smsCode,
    required PhoneAuthCredential credential,
  }) =>
      resultOf(() async {
        final verificationId = credential.verificationId;
        if (verificationId == null) {
          return Result.error(const InvalidVerificationIdAuthException());
        }

        final credentials = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        UserCredential? userCredentials;
        try {
          userCredentials = await firebaseAuth.signInWithCredential(credentials);
        } catch (e) {
          final currentUser = firebaseAuth.currentUser;
          if (currentUser != null && currentUser.isAnonymous) {
            try {
              userCredentials = await currentUser.linkWithCredential(credentials);
            } catch (e) {
              if (e is FirebaseAuthException && e.code == 'invalid-phone-number') {
                return Result.error(const InvalidPhoneNumberException());
              } else {
                return Result.error(e);
              }
            }
          } else {
            if (e is FirebaseAuthException && e.code == 'invalid-phone-number') {
              return Result.error(const InvalidPhoneNumberException());
            } else {
              return Result.error(e);
            }
          }
        }

        if (userCredentials.user != null && !userCredentials.user!.isAnonymous) {
          return Result.value(null);
        } else {
          return Result.error(Exception('userCredentials == null'));
        }
      });

  @override
  Future<Result<PhoneAuthCredential>> startSignInWithPhone({
    required String phoneNumber,
    required Country country,
  }) =>
      resultOf(() async {
        final credentials = await firebaseAuth.startSignInWithPhone(
          phoneNumber: phoneNumber,
          dialCode: country.dialCode,
        );

        return Result.value(credentials);
      });
}
