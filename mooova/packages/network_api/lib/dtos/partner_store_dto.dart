import 'package:json_annotation/json_annotation.dart';

part 'partner_store_dto.g.dart';

@JsonSerializable()
class PartnerStoresDto {
  @JsonKey(name: 'stores')
  final PartnerStoreDto stores;

  const PartnerStoresDto({
    required this.stores,
  });

  factory PartnerStoresDto.fromJson(Map<String, dynamic> json) => _$PartnerStoresDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerStoresDtoToJson(this);
}

@JsonSerializable()
class PartnerStoreDto {
  @JsonKey(name: 'name')
  final String name;

  const PartnerStoreDto({
    required this.name,
  });

  factory PartnerStoreDto.fromJson(Map<String, dynamic> json) => _$PartnerStoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerStoreDtoToJson(this);
}
