// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_notifications_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettingsNotificationsDto _$UserSettingsNotificationsDtoFromJson(
        Map<String, dynamic> json) =>
    UserSettingsNotificationsDto(
      mutedNotifications: (json['mutedNotifications'] as List<dynamic>)
          .map((e) => UserSettingsNotificationsMutedDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSettingsNotificationsDtoToJson(
        UserSettingsNotificationsDto instance) =>
    <String, dynamic>{
      'mutedNotifications': instance.mutedNotifications,
    };

UserSettingsNotificationsMutedDto _$UserSettingsNotificationsMutedDtoFromJson(
        Map<String, dynamic> json) =>
    UserSettingsNotificationsMutedDto(
      type: json['type'] as String,
      orderSize: json['orderSize'] as String?,
    );

Map<String, dynamic> _$UserSettingsNotificationsMutedDtoToJson(
    UserSettingsNotificationsMutedDto instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('orderSize', instance.orderSize);
  return val;
}
