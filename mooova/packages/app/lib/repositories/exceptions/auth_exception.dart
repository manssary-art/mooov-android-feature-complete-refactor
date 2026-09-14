
sealed class AuthException implements Exception {
  final String? message;

  const AuthException({
    this.message,
  });

  @override
  String toString() => "AuthException($message)";
}


class NotAuthenticatedException extends AuthException {
  const NotAuthenticatedException();
}

class InvalidVerificationIdAuthException extends AuthException {
  const InvalidVerificationIdAuthException();
}
