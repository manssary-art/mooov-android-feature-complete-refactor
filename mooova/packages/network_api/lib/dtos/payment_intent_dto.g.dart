// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentCreateDto _$PaymentIntentCreateDtoFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentCreateDto(
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      workerId: json['moooverId'] as String,
      finalPickupTime: json['finalPickupTime'] as int,
      promoCode: json['promoCode'] as String?,
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$PaymentIntentCreateDtoToJson(
        PaymentIntentCreateDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'moooverId': instance.workerId,
      'finalPickupTime': instance.finalPickupTime,
      'promoCode': instance.promoCode,
      'paymentMethod': instance.paymentMethod,
    };

PaymentIntentDto _$PaymentIntentDtoFromJson(Map<String, dynamic> json) =>
    PaymentIntentDto(
      publishableKey: json['publishableKey'] as String,
      clientSecret: json['clientSecret'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      vatAmount: (json['vatAmount'] as num).toDouble(),
      userCustomerId: json['userCustomerId'] as String,
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$PaymentIntentDtoToJson(PaymentIntentDto instance) =>
    <String, dynamic>{
      'publishableKey': instance.publishableKey,
      'clientSecret': instance.clientSecret,
      'totalAmount': instance.totalAmount,
      'discountAmount': instance.discountAmount,
      'vatAmount': instance.vatAmount,
      'userCustomerId': instance.userCustomerId,
      'currencyCode': instance.currencyCode,
    };
