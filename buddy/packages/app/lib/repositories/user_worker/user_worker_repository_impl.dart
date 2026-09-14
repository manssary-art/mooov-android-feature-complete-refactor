import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network_api/apis/user_api.dart';
import 'package:network_api/apis/worker_application_api.dart';
import 'package:network_api/dtos/user_update_dto.dart';
import 'package:network_api/dtos/worker_vehicle_info_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/user_mapper.dart';
import '../../models/mappers/worker_application_form_mapper.dart';
import '../../models/user_model.dart';
import '../../models/worker_application_form_model.dart';
import '../exceptions/auth_exception.dart';
import 'user_worker_repository.dart';

class UserWorkerRepositoryImpl implements UserWorkerRepository {
  final FirebaseAuth firebaseAuth;
  final UserApi userApi;
  final WorkerApplicationApi workerApplicationApi;
  final StreamController<UserModel> _onUserChanged;

  UserWorkerRepositoryImpl({
    required this.firebaseAuth,
    required this.userApi,
    required this.workerApplicationApi,
    required StreamController<UserModel> onUserChanged,
  }) : _onUserChanged = onUserChanged;

  @override
  Future<Result<UserModel>> setVehicleImage({
    required String imageUrl,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return _setImages(
          userId: currentUser.uid,
          profileUrl: null,
          vehicleUrl: imageUrl,
        );
      });

  @override
  Future<Result<WorkerApplicationFormModel>> getApplicationForm() => resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return _getUser().flatMapValue((user) {
          if (user.workerApplicationId == null) {
            return Result.value(const WorkerApplicationFormModel());
          } else {
            return workerApplicationApi
                .getWorkerApplication(userId: user.userId)
                .asHttpResponseResult()
                .mapValue((e) => e.toWorkerApplicationFormModel(user));
          }
        });
      });

  @override
  Future<Result<void>> createApplicationForm({
    required WorkerApplicationFormModel form,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return _getUser()
            .flatMapValue((user) => workerApplicationApi
                .createWorkerApplication(body: form.toWorkerApplicationCreateDto(user))
                .asHttpResponseResult()
                .mapValue((e) => user))
            .flatMapValue((user) => _setImages(
                  userId: user.userId,
                  profileUrl: form.vehicleUrl,
                  vehicleUrl: form.vehicleUrl,
                ));
      });

  @override
  Future<Result<void>> updateApplicationForm({
    required WorkerApplicationFormModel form,
  }) =>
      resultOf(() async {
        final currentUser = firebaseAuth.currentUser;
        if (currentUser == null || currentUser.isAnonymous) {
          return Result.error(const NotAuthenticatedException());
        }

        return _getUser()
            .flatMapValue((user) => workerApplicationApi
                .updateWorkerApplication(userId: user.userId, body: form.toWorkerApplicationUpdateDto(user))
                .asHttpResponseResult()
                .mapValue((e) => user))
            .flatMapValue((user) => _setImages(
                  userId: user.userId,
                  profileUrl: form.vehicleUrl,
                  vehicleUrl: form.vehicleUrl,
                ));
      });

  Future<Result<UserModel>> _getUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null || currentUser.isAnonymous) {
      return Result.error(const NotAuthenticatedException());
    }

    return userApi
        .getUserById(userId: currentUser.uid)
        .asHttpResponseResult()
        .mapValue((e) => e.toUserModel())
        .onValue((e) => _onUserChanged.add(e));
  }

  Future<Result<UserModel>> _setImages({
    required String userId,
    required String? vehicleUrl,
    required String? profileUrl,
  }) async {
    return userApi
        .updateUser(
          userId: userId,
          body: UserUpdateDto(
            userId: userId,
            image: profileUrl,
            vehicles: vehicleUrl?.let((it) => [WorkerVehicleInfo(imageUrl: it, plate: null)]),
          ),
        )
        .asHttpResponseResult()
        .mapValue((e) => e.toUserModel())
        .onValue((e) => _onUserChanged.add(e));
  }
}
