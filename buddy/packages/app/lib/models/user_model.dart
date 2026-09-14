import 'dart:math';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'geo_point_model.dart';
import 'types/user_level_type.dart';
import 'types/user_notification_type.dart';
import 'types/user_role_type.dart';
import 'user_info_business_model.dart';
import 'user_info_referral_model.dart';
import 'user_info_worker_model.dart';

class UserModel with EquatableMixin {
  final String userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? image;
  final String? email;
  final Country country;
  final int? orderCounter;
  final String? fcmToken;
  final UserLevel? level;
  final GeoPointModel? geoPoint;
  final UserRole role;
  final String? workerApplicationId;
  final List<UserNotificationType>? mutedNotifications;
  final UserInfoWorkerModel? workerInfo;
  final UserInfoReferralModel? referralInfo;
  final UserInfoBusinessModel? businessInfo;

  const UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.email,
    required this.role,
    required this.country,
    required this.orderCounter,
    required this.fcmToken,
    required this.geoPoint,
    required this.level,
    required this.mutedNotifications,
    required this.businessInfo,
    required this.workerInfo,
    required this.referralInfo,
    required this.workerApplicationId,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        phone,
        image,
        email,
        role,
        country,
        orderCounter,
        fcmToken,
        geoPoint,
        level,
        mutedNotifications,
        businessInfo,
        workerInfo,
        referralInfo,
        workerApplicationId,
      ];

  UserModel copyWith({
    String Function()? userId,
    String? Function()? firstName,
    String? Function()? lastName,
    String? Function()? phone,
    String? Function()? image,
    String? Function()? email,
    Country Function()? country,
    int? Function()? orderCounter,
    String? Function()? fcmToken,
    UserLevel? Function()? level,
    GeoPointModel? Function()? geoPoint,
    UserRole Function()? role,
    String? Function()? workerApplicationId,
    List<UserNotificationType>? Function()? mutedNotifications,
    UserInfoWorkerModel? Function()? workerInfo,
    UserInfoReferralModel? Function()? referralInfo,
    UserInfoBusinessModel? Function()? businessInfo,
  }) {
    return UserModel(
      userId: userId != null ? userId() : this.userId,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      phone: phone != null ? phone() : this.phone,
      image: image != null ? image() : this.image,
      email: email != null ? email() : this.email,
      country: country != null ? country() : this.country,
      orderCounter: orderCounter != null ? orderCounter() : this.orderCounter,
      fcmToken: fcmToken != null ? fcmToken() : this.fcmToken,
      level: level != null ? level() : this.level,
      geoPoint: geoPoint != null ? geoPoint() : this.geoPoint,
      role: role != null ? role() : this.role,
      workerApplicationId: workerApplicationId != null ? workerApplicationId() : this.workerApplicationId,
      mutedNotifications: mutedNotifications != null ? mutedNotifications() : this.mutedNotifications,
      workerInfo: workerInfo != null ? workerInfo() : this.workerInfo,
      referralInfo: referralInfo != null ? referralInfo() : this.referralInfo,
      businessInfo: businessInfo != null ? businessInfo() : this.businessInfo,
    );
  }
}

extension UserModelExt on UserModel {
  String get displayName => firstName ?? '';

  String get displayNameObfuscated => displayName.let((it) => '${it.substring(0, min(it.length, 3))}***');
}
