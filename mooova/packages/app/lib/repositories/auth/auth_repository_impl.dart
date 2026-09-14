import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.firebaseAuth,
  }) : isAuthenticatedChanged = firebaseAuth.authStateChanges().map((e) => e != null && !e.isAnonymous);

  @override
  final Stream<bool> isAuthenticatedChanged;

  @override
  Future<Result<bool>> isAuthenticated() => resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        return Result.value(currentUser != null && !currentUser.isAnonymous);
      });

  @override
  Future<Result<void>> signOut() => resultOf(() async {
        await firebaseAuth.signOut();
        return Result.value(null);
      });
}
