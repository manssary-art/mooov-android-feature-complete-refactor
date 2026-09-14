import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/user_model.dart';
import '../exceptions/auth_exception.dart';

abstract interface class UserRepository {
  Stream<UserModel> get onUserChanged;

  Future<Result<String>> getUserId();

  Future<Result<UserModel>> getUser();

  Future<Result<UserModel>> createUser({
    required String firstName,
    required String lastName,
    required Country country,
    required String phoneNumber,
    String? email,
    String? referralCode,
  });

  Future<Result<UserModel>> setUserFcmToken({
    required String fcmToken,
  });

  Future<Result<UserModel>> setUserProfileImage({
    required String imageUrl,
  });

  Future<Result<UserModel>> setUserInfo({
    String? firstName,
    String? lastName,
    String? email,
  });

  Future<Result<UserModel>> setBusinessInfo({
    String? companyName,
    String? companyVat,
    String? companyAddress,
    String? email,
  });
}

extension UserRepositoryExt on UserRepository {
  Future<Result<UserModel?>> getUserOrNull() => getUser().mapValue<UserModel?>((e) => e).flatMapError((e, s) {
        return e is NotAuthenticatedException ? Result.value(null) : Result.error(e, s);
      });

  Future<Result<String?>> getUserIdOrNull() => getUserId()
      .mapValue<String?>((e) => e)
      .flatMapError((e, s) => e is NotAuthenticatedException ? Result.value(null) : Result.error(e, s));
}
