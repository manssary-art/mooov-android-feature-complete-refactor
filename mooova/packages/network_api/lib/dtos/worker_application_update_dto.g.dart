// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_application_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerApplicationUpdateDto _$WorkerApplicationUpdateDtoFromJson(
        Map<String, dynamic> json) =>
    WorkerApplicationUpdateDto(
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
      vehiclePlateUrls: (json['vehiclePlate'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bank: json['bank'] == null
          ? null
          : BankInfoDto.fromJson(json['bank'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkerApplicationUpdateDtoToJson(
    WorkerApplicationUpdateDto instance) {
  final val = <String, dynamic>{
    'id': instance.applicationId,
    'userId': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('birth', instance.birthdate);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.countryCode);
  writeNotNull('email', instance.email);
  writeNotNull('selfie', instance.selfie);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('approved', instance.isApproved);
  writeNotNull('idCard', instance.idCardUrls);
  writeNotNull('vehiclePlate', instance.vehiclePlateUrls);
  writeNotNull('bank', instance.bank);
  return val;
}
