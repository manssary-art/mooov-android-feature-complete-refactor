import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'user_info_business_model.dart';

class WorkerApplicationFormModel with EquatableMixin {
  final String? applicationId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? birthday;
  final String? streetAddress;
  final String? zipCode;
  final String? city;
  final Country? country;
  final String? vehiclePlate;
  final String? iban;
  final UserInfoBusinessModel? businessInfo;
  final String? selfieUrl;
  final String? idFrontUrl;
  final String? idBackUrl;
  final String? vehicleUrl;
  final bool isApproved;

  const WorkerApplicationFormModel({
    this.applicationId,
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
    this.streetAddress,
    this.zipCode,
    this.city,
    this.country,
    this.vehiclePlate,
    this.iban,
    this.businessInfo,
    this.selfieUrl,
    this.idFrontUrl,
    this.idBackUrl,
    this.vehicleUrl,
    this.isApproved = false,
  });

  @override
  List<Object?> get props => [
        applicationId,
        firstName,
        lastName,
        email,
        birthday,
        streetAddress,
        zipCode,
        city,
        country,
        vehiclePlate,
        iban,
        businessInfo,
        selfieUrl,
        idFrontUrl,
        idBackUrl,
        vehicleUrl,
        isApproved,
      ];

  WorkerApplicationFormModel copyWith({
    String? Function()? applicationId,
    String? Function()? firstName,
    String? Function()? lastName,
    String? Function()? email,
    DateTime? Function()? birthday,
    String? Function()? streetAddress,
    String? Function()? zipCode,
    String? Function()? city,
    Country? Function()? country,
    String? Function()? vehiclePlate,
    String? Function()? iban,
    UserInfoBusinessModel? Function()? businessInfo,
    String? Function()? selfieUrl,
    String? Function()? idFrontUrl,
    String? Function()? idBackUrl,
    String? Function()? vehicleUrl,
    bool Function()? isApproved,
  }) {
    return WorkerApplicationFormModel(
      applicationId: applicationId != null ? applicationId() : this.applicationId,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      email: email != null ? email() : this.email,
      birthday: birthday != null ? birthday() : this.birthday,
      streetAddress: streetAddress != null ? streetAddress() : this.streetAddress,
      zipCode: zipCode != null ? zipCode() : this.zipCode,
      city: city != null ? city() : this.city,
      country: country != null ? country() : this.country,
      vehiclePlate: vehiclePlate != null ? vehiclePlate() : this.vehiclePlate,
      iban: iban != null ? iban() : this.iban,
      businessInfo: businessInfo != null ? businessInfo() : this.businessInfo,
      selfieUrl: selfieUrl != null ? selfieUrl() : this.selfieUrl,
      idFrontUrl: idFrontUrl != null ? idFrontUrl() : this.idFrontUrl,
      idBackUrl: idBackUrl != null ? idBackUrl() : this.idBackUrl,
      vehicleUrl: vehicleUrl != null ? vehicleUrl() : this.vehicleUrl,
      isApproved: isApproved != null ? isApproved() : this.isApproved,
    );
  }
}
