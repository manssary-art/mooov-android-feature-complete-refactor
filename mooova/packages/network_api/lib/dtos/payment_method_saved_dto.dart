import 'package:json_annotation/json_annotation.dart';

part 'payment_method_saved_dto.g.dart';

@JsonSerializable()
class PaymentMethodSavedDto {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'card')
  final PaymentMethodSavedCardInfoDto? card;

  const PaymentMethodSavedDto({
    required this.id,
    required this.card,
  });

  factory PaymentMethodSavedDto.fromJson(Map<String, dynamic> json) => _$PaymentMethodSavedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodSavedDtoToJson(this);
}

@JsonSerializable()
class PaymentMethodSavedCardInfoDto {
  @JsonKey(name: 'last4')
  final String last4;
  @JsonKey(name: 'brand')
  final String brand;

  const PaymentMethodSavedCardInfoDto({
    required this.last4,
    required this.brand,
  });

  factory PaymentMethodSavedCardInfoDto.fromJson(Map<String, dynamic> json) => _$PaymentMethodSavedCardInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodSavedCardInfoDtoToJson(this);
}
