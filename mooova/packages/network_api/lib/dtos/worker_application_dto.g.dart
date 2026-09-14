// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerApplicationDto _$WorkerApplicationDtoFromJson(
        Map<String, dynamic> json) =>
    WorkerApplicationDto(
      applicationId: json['id'] as String,
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthdate: json['birth'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      countryCode: json['country'] as String?,
      email: json['email'] as String?,
      selfie: json['selfie'] as String?,
      postalCode: json['postalCode'] as String?,
      isApproved: json['approved'] as bool?,
      idCardUrls:
          (json['idCard'] as List<dynamic>?)?.map((e) => e as String).toList(),
      vehiclePlate: (json['vehiclePlate'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bank: json['bank'] == null
          ? null
          : BankInfoDto.fromJson(json['bank'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkerApplicationDtoToJson(
        WorkerApplicationDto instance) =>
    <String, dynamic>{
      'id': instance.applicationId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birth': instance.birthdate,
      'address': instance.address,
      'city': instance.city,
      'country': instance.countryCode,
      'email': instance.email,
      'selfie': instance.selfie,
      'postalCode': instance.postalCode,
      'approved': instance.isApproved,
      'idCard': instance.idCardUrls,
      'vehiclePlate': instance.vehiclePlate,
      'bank': instance.bank,
    };
