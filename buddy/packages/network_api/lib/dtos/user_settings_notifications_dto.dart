import 'package:json_annotation/json_annotation.dart';

part 'user_settings_notifications_dto.g.dart';

@JsonSerializable()
class UserSettingsNotificationsDto {
  @JsonKey(name: 'mutedNotifications')
  final List<UserSettingsNotificationsMutedDto> mutedNotifications;

  const UserSettingsNotificationsDto({
    required this.mutedNotifications,
  });

  factory UserSettingsNotificationsDto.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsNotificationsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsNotificationsDtoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UserSettingsNotificationsMutedDto {
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'orderSize')
  final String? orderSize;

  const UserSettingsNotificationsMutedDto({
    required this.type,
    required this.orderSize,
  });

  factory UserSettingsNotificationsMutedDto.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsNotificationsMutedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsNotificationsMutedDtoToJson(this);
}
