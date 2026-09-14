import 'package:core/core.dart';
import 'package:network_api/dtos/user_business_info_dto.dart';
import 'package:network_api/dtos/user_dto.dart';
import 'package:network_api/dtos/user_referral_info_dto.dart';

import '../types/user_level_type.dart';
import '../types/user_notification_type.dart';
import '../types/user_role_type.dart';
import '../user_info_business_model.dart';
import '../user_info_referral_model.dart';
import '../user_info_worker_model.dart';
import '../user_model.dart';
import 'geo_point_mapper.dart';

extension UserDtoMapperExt on UserDto {
  UserModel toUserModel() => UserModel(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        image: image,
        email: email,
        role: role?.toUserRole() ?? UserRole.user,
        country: country?.toCountryOrNull() ?? Country.SE,
        orderCounter: orderCounter,
        fcmToken: fcmToken,
        level: level?.toUserLevel() ?? UserLevel.bronze,
        geoPoint: geoPoint?.toGeoPointModel(),
        mutedNotifications:
            settings?.notifications.mutedNotifications.mapNotNull((e) => e.toUserNotificationTypeOrNull()),
        businessInfo: businessInfo?.toUserInfoBusinessModel(),
        workerApplicationId: application,
        workerInfo: role?.toUserRole() == UserRole.worker || application != null ? _toUserInfoWorkerModel() : null,
        referralInfo: referral?.toUserInfoReferralModel(),
      );

  UserInfoWorkerModel _toUserInfoWorkerModel() => UserInfoWorkerModel(
        rating: rating,
        cutRate: cutRate,
        orderDeliverCounter: orderDeliverCounter,
        vehiclesImagesUrls: vehicles?.mapNotNull((e) => e.imageUrl),
        tags: tags,
      );
}

extension UserBusinessInfoDtoMapperExt on UserBusinessInfoDto {
  UserInfoBusinessModel toUserInfoBusinessModel() => UserInfoBusinessModel(
        name: name,
        vatNumber: vatNumber,
        address: address,
        hasTrafficPermit: hasTrafficPermit,
      );
}

extension UserInfoBusinessModelMapperExt on UserInfoBusinessModel {
  UserBusinessInfoDto toUserBusinessInfoDto() => UserBusinessInfoDto(
        name: name,
        vatNumber: vatNumber,
        address: address,
        hasTrafficPermit: hasTrafficPermit,
      );
}

extension UserReferralInfoDtoMapperExt on UserReferralInfoDto {
  UserInfoReferralModel toUserInfoReferralModel() => UserInfoReferralModel(
        referralCode: referralCode,
        referralLink: referralLink,
        referredBy: referredBy,
      );
}
