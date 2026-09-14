import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';

GoRouterRedirect requireAuthenticatedRedirect({
  required String go,
  String? push,
}) =>
    (context, state) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null || currentUser.isAnonymous) {
        if (push != null) {
          Future.microtask(() => router.push(push));
        }
        return go;
      }

      return null;
    };

GoRouterRedirect requireUnauthenticatedRedirect({
  required String go,
  String? push,
}) =>
    (context, state) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && !currentUser.isAnonymous) {
        if (push != null) {
          Future.microtask(() => router.push(push));
        }
        return go;
      }

      return null;
    };
