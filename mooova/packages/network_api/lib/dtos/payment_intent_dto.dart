import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_dto.g.dart';

@JsonSerializable()
class PaymentIntentCreateDto {
  @JsonKey(name: 'orderId')
  final String orderId;
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'moooverId')
  final String workerId;
  @JsonKey(name: 'finalPickupTime')
  final int finalPickupTime;
  @JsonKey(name: 'promoCode')
  final String? promoCode;
  @JsonKey(name: 'paymentMethod')
  final String paymentMethod;

  const PaymentIntentCreateDto({
    required this.orderId,
    required this.userId,
    required this.workerId,
    required this.finalPickupTime,
    required this.promoCode,
    required this.paymentMethod,
  });

  factory PaymentIntentCreateDto.fromJson(Map<String, dynamic> json) => _$PaymentIntentCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentCreateDtoToJson(this);
}

@JsonSerializable()
class PaymentIntentDto {
  @JsonKey(name: 'publishableKey')
  final String publishableKey;
  @JsonKey(name: 'clientSecret')
  final String clientSecret;
  @JsonKey(name: 'totalAmount')
  final double totalAmount;
  @JsonKey(name: 'discountAmount')
  final double discountAmount;
  @JsonKey(name: 'vatAmount')
  final double vatAmount;
  @JsonKey(name: 'userCustomerId')
  final String userCustomerId;
  @JsonKey(name: 'currencyCode')
  final String currencyCode;

  const PaymentIntentDto({
    required this.publishableKey,
    required this.clientSecret,
    required this.totalAmount,
    required this.discountAmount,
    required this.vatAmount,
    required this.userCustomerId,
    required this.currencyCode,
  });

  factory PaymentIntentDto.fromJson(Map<String, dynamic> json) => _$PaymentIntentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentDtoToJson(this);
}
