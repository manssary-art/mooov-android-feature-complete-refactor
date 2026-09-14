// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_saved_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodSavedDto _$PaymentMethodSavedDtoFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodSavedDto(
      id: json['id'] as String,
      card: json['card'] == null
          ? null
          : PaymentMethodSavedCardInfoDto.fromJson(
              json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodSavedDtoToJson(
        PaymentMethodSavedDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card': instance.card,
    };

PaymentMethodSavedCardInfoDto _$PaymentMethodSavedCardInfoDtoFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodSavedCardInfoDto(
      last4: json['last4'] as String,
      brand: json['brand'] as String,
    );

Map<String, dynamic> _$PaymentMethodSavedCardInfoDtoToJson(
        PaymentMethodSavedCardInfoDto instance) =>
    <String, dynamic>{
      'last4': instance.last4,
      'brand': instance.brand,
    };
