import 'package:async/async.dart';

abstract interface class AuthRepository {
  Stream<bool> get isAuthenticatedChanged;

  Future<Result<bool>> isAuthenticated();

  Future<Result<void>> signOut();
}
