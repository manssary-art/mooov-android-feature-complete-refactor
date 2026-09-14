import 'package:json_annotation/json_annotation.dart';

part 'address_contact_dto.g.dart';

@JsonSerializable()
class AddressContactDto {
  @JsonKey(name: 'phone')
  final String? phone;

  const AddressContactDto({
    required this.phone,
  });

  factory AddressContactDto.fromJson(Map<String, dynamic> json) => _$AddressContactDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressContactDtoToJson(this);
}
