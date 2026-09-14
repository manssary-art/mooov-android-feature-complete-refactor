import 'package:json_annotation/json_annotation.dart';

import 'bank_info_dto.dart';

part 'worker_application_create_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class WorkerApplicationCreateDto {
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'birth')
  final String? birthdate;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'country')
  final String? countryCode;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'selfie')
  final String? selfie;
  @JsonKey(name: 'postalCode')
  final String? postalCode;
  @JsonKey(name: 'approved')
  final bool? isApproved;
  @JsonKey(name: 'idCard')
  final List<String>? idCardUrls;
  @JsonKey(name: 'vehiclePlate')
  final List<String>? vehiclePlateUrls;
  @JsonKey(name: 'bank')
  final BankInfoDto? bank;

  const WorkerApplicationCreateDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.address,
    required this.city,
    required this.countryCode,
    required this.email,
    required this.selfie,
    required this.postalCode,
    required this.isApproved,
    required this.idCardUrls,
    required this.vehiclePlateUrls,
    required this.bank,
  });

  factory WorkerApplicationCreateDto.fromJson(Map<String, dynamic> json) => _$WorkerApplicationCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerApplicationCreateDtoToJson(this);
}
