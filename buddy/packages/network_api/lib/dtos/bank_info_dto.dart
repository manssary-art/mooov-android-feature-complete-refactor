import 'package:json_annotation/json_annotation.dart';

part 'bank_info_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class BankInfoDto {
  @JsonKey(name: 'country')
  final String? countryCode;
  @JsonKey(name: 'clearingNumber')
  final String? clearingNumber;
  @JsonKey(name: 'accountNumber')
  final String? accountNumber;
  @JsonKey(name: 'iban')
  final String? iban;

  const BankInfoDto({
    required this.countryCode,
    required this.clearingNumber,
    required this.accountNumber,
    required this.iban,
  });

  factory BankInfoDto.fromJson(Map<String, dynamic> json) => _$BankInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BankInfoDtoToJson(this);
}
