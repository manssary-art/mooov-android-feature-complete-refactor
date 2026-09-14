import 'package:network_api/dtos/user_settings_notifications_dto.dart';

enum UserNotificationType {
  orderSizeS,
  orderSizeM,
  orderSizeL,
  activitiesUpdate,
  promotions,
  giveAway,
}

extension UserNotificationTypeUserSettingsNotificationsMutedDtoExt on UserNotificationType {
  UserSettingsNotificationsMutedDto toUserMutatedNotificationDto() {
    switch (this) {
      case UserNotificationType.orderSizeS:
        return const UserSettingsNotificationsMutedDto(
          type: 'ORDER_NEW',
          orderSize: 'S',
        );
      case UserNotificationType.orderSizeM:
        return const UserSettingsNotificationsMutedDto(
          type: 'ORDER_NEW',
          orderSize: 'M',
        );
      case UserNotificationType.orderSizeL:
        return const UserSettingsNotificationsMutedDto(
          type: 'ORDER_NEW',
          orderSize: 'L',
        );
      case UserNotificationType.activitiesUpdate:
        return const UserSettingsNotificationsMutedDto(
          type: 'ORDER_UPDATED',
          orderSize: null,
        );
      case UserNotificationType.giveAway:
        return const UserSettingsNotificationsMutedDto(
          type: 'ORDER_GIVE_AWAY_NEW',
          orderSize: null,
        );
      case UserNotificationType.promotions:
        return const UserSettingsNotificationsMutedDto(
          type: 'NEWS_AND_PROMOTIONS',
          orderSize: null,
        );
    }
  }
}

extension UserSettingsNotificationsMutedDtoUserNotificationTypeExt on UserSettingsNotificationsMutedDto {
  UserNotificationType? toUserNotificationTypeOrNull() {
    if (type == 'ORDER_NEW') {
      switch (orderSize) {
        case 'S':
          return UserNotificationType.orderSizeS;
        case 'M':
          return UserNotificationType.orderSizeM;
        case 'L':
          return UserNotificationType.orderSizeL;
        default:
          return null;
      }
    }

    if (type == 'ORDER_UPDATED') {
      return UserNotificationType.activitiesUpdate;
    }

    if (type == 'ORDER_GIVE_AWAY_NEW') {
      return UserNotificationType.giveAway;
    }
    if (type == 'NEWS_AND_PROMOTIONS') {
      return UserNotificationType.promotions;
    }

    return null;
  }
}
