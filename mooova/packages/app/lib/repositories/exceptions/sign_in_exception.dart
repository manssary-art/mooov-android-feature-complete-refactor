sealed class SignInException implements Exception {
  final String? message;

  const SignInException({
    this.message,
  });

  @override
  String toString() => "SignInException($message)";
}

class InvalidVerificationIdAuthException extends SignInException {
  const InvalidVerificationIdAuthException();
}

class InvalidPhoneNumberException extends SignInException {
  const InvalidPhoneNumberException();
}
