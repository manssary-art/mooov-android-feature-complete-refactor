import 'package:firebase_auth/firebase_auth.dart';

Future<PhoneAuthCredential> startSignInWithPhone({
  required FirebaseAuth firebaseAuth,
  required String phoneNumber,
  Duration timeout = const Duration(minutes: 1),
}) async {
  final result = await firebaseAuth.signInWithPhoneNumber(phoneNumber);
  return PhoneAuthProvider.credential(verificationId: result.verificationId, smsCode: '');
}
