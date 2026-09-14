import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthenticationRequest {
  final String phoneNumber;
  final Country country;
  final PhoneAuthCredential credential;

  PhoneAuthenticationRequest({
    required this.phoneNumber,
    required this.country,
    required this.credential,
  });
}
