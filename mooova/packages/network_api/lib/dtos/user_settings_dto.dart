import 'package:json_annotation/json_annotation.dart';

import 'user_settings_notifications_dto.dart';

part 'user_settings_dto.g.dart';

@JsonSerializable()
class UserSettingsDto {
  @JsonKey(name: 'notification')
  final UserSettingsNotificationsDto notifications;

  const UserSettingsDto({
    required this.notifications,
  });

  factory UserSettingsDto.fromJson(Map<String, dynamic> json) => _$UserSettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsDtoToJson(this);
}
