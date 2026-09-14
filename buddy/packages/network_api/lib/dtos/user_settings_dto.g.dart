// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettingsDto _$UserSettingsDtoFromJson(Map<String, dynamic> json) =>
    UserSettingsDto(
      notifications: UserSettingsNotificationsDto.fromJson(
          json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSettingsDtoToJson(UserSettingsDto instance) =>
    <String, dynamic>{
      'notification': instance.notifications,
    };
