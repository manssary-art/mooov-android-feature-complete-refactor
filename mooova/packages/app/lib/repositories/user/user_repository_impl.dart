import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network_api/apis/user_api.dart';
import 'package:network_api/dtos/user_create_dto.dart';
import 'package:network_api/dtos/user_referral_info_dto.dart';
import 'package:network_api/dtos/user_update_dto.dart';
import 'package:network_api/dtos/worker_vehicle_info_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/user_mapper.dart';
import '../../models/user_info_business_model.dart';
import '../../models/user_model.dart';
import '../exceptions/auth_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth firebaseAuth;
  final UserApi userApi;
  final StreamController<UserModel> _onUserChanged;

  UserRepositoryImpl({
    required this.firebaseAuth,
    required this.userApi,
    required StreamController<UserModel> onUserChanged,
  }) : _onUserChanged = onUserChanged;

  @override
  Stream<UserModel> get onUserChanged => _onUserChanged.stream;

  @override
  Future<Result<UserModel>> getUser() => getUserId().flatMapValue((userId) async {
        return await userApi
            .getUserById(userId: userId)
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<String>> getUserId() => resultOf(() async {
        var currentUser = firebaseAuth.currentUser;
        if (currentUser == null) {
          final credential = await firebaseAuth.signInAnonymously();
          currentUser = credential.user;
        }

        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        } else {
          return Result.value(currentUser.uid);
        }
      });

  @override
  Future<Result<UserModel>> createUser({
    required String firstName,
    required String lastName,
    required Country country,
    required String phoneNumber,
    String? email,
    String? referralCode,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return userApi
            .createUser(
              body: UserCreateDto(
                id: currentUser.uid,
                firstName: firstName,
                lastName: lastName,
                email: email?.isValidEmail == true ? email : null,
                country: country.code,
                phone: "${country.dialCode}$phoneNumber",
                referral: referralCode != null ? UserReferralInfoDto(referredBy: referralCode) : null,
              ),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<UserModel>> setUserFcmToken({
    required String fcmToken,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return userApi
            .updateUser(
              userId: currentUser.uid,
              body: UserUpdateDto(
                userId: currentUser.uid,
                fcmToken: fcmToken,
              ),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<UserModel>> setUserProfileImage({
    required String imageUrl,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return userApi
            .updateUser(
              userId: currentUser.uid,
              body: UserUpdateDto(
                userId: currentUser.uid,
                image: imageUrl,
              ),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<UserModel>> setVehicleImage({
    required String imageUrl,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return userApi
            .updateUser(
              userId: currentUser.uid,
              body: UserUpdateDto(userId: currentUser.uid, vehicles: [
                WorkerVehicleInfo(imageUrl: imageUrl, plate: null),
              ]),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<UserModel>> setUserInfo({
    String? firstName,
    String? lastName,
    String? email,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return userApi
            .updateUser(
              userId: currentUser.uid,
              body: UserUpdateDto(
                userId: currentUser.uid,
                firstName: firstName,
                lastName: lastName,
                email: email?.isValidEmail == true ? email : null,
              ),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.toUserModel())
            .onValue((e) => _onUserChanged.add(e));
      });

  @override
  Future<Result<UserModel>> setBusinessInfo({
    String? companyName,
    String? companyVat,
    String? companyAddress,
    String? email,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return getUser().flatMapValue((user) async {
          if (companyName == null && companyVat == null && companyAddress == null && email == null) {
            return Result.value(user);
          } else {
            final info = (user.businessInfo ?? const UserInfoBusinessModel()).copyWith(
              name: companyName?.copy,
              address: companyAddress?.copy,
              vatNumber: companyVat.copy,
            );

            return userApi
                .updateUser(
                  userId: user.userId,
                  body: UserUpdateDto(
                    userId: currentUser.uid,
                    businessInfo: info.toUserBusinessInfoDto(),
                    email: email?.isValidEmail == true ? email : user.email,
                  ),
                )
                .asHttpResponseResult()
                .mapValue((e) => e.toUserModel())
                .onValue((e) => _onUserChanged.add(e));
          }
        });
      });
}
