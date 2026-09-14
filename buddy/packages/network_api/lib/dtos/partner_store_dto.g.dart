// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_store_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerStoresDto _$PartnerStoresDtoFromJson(Map<String, dynamic> json) =>
    PartnerStoresDto(
      stores: PartnerStoreDto.fromJson(json['stores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerStoresDtoToJson(PartnerStoresDto instance) =>
    <String, dynamic>{
      'stores': instance.stores,
    };

PartnerStoreDto _$PartnerStoreDtoFromJson(Map<String, dynamic> json) =>
    PartnerStoreDto(
      name: json['name'] as String,
    );

Map<String, dynamic> _$PartnerStoreDtoToJson(PartnerStoreDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
