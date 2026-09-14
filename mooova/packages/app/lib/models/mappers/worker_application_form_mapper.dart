import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:network_api/dtos/bank_info_dto.dart';
import 'package:network_api/dtos/worker_application_create_dto.dart';
import 'package:network_api/dtos/worker_application_dto.dart';
import 'package:network_api/dtos/worker_application_update_dto.dart';

import '../user_model.dart';
import '../worker_application_form_model.dart';

final _applicationBirthdayFormatter = DateFormat().addPattern('yyyy-MM-dd');

extension WorkerApplicationFormDtoWorkerApplicationFormModelExt on WorkerApplicationDto {
  WorkerApplicationFormModel toWorkerApplicationFormModel(UserModel user) {
    return WorkerApplicationFormModel(
      applicationId: user.workerApplicationId,
      firstName: firstName,
      lastName: lastName,
      country: countryCode?.toCountryOrNull(),
      streetAddress: address,
      city: city,
      zipCode: postalCode,
      email: email,
      iban: bank?.iban,
      birthday: birthdate?.let(_applicationBirthdayFormatter.parseOrNull),
      idFrontUrl: idCardUrls?.getAtOrNull(0),
      idBackUrl: idCardUrls?.getAtOrNull(1),
      selfieUrl: selfie,
      vehicleUrl: user.workerInfo?.vehiclesImagesUrls?.firstOrNull(),
      vehiclePlate: vehiclePlate?.firstOrNull(),
      isApproved: isApproved ?? false,
    );
  }
}

extension WorkerApplicationFormModelWorkerApplicationFormDtoExt on WorkerApplicationFormModel {
  WorkerApplicationCreateDto toWorkerApplicationCreateDto(UserModel user) {
    return WorkerApplicationCreateDto(
      userId: user.userId,
      firstName: firstName,
      lastName: lastName,
      countryCode: country?.code,
      address: streetAddress,
      city: city,
      postalCode: zipCode,
      email: email,
      bank: iban?.let(
        (it) => BankInfoDto(
          countryCode: country?.code,
          clearingNumber: null,
          accountNumber: null,
          iban: iban,
        ),
      ),
      birthdate: birthday?.let(_applicationBirthdayFormatter.format),
      idCardUrls: [idFrontUrl, idBackUrl].mapNotNull((e) => e).toList(),
      selfie: selfieUrl,
      vehiclePlateUrls: [vehiclePlate].mapNotNull((e) => e).toList(),
      isApproved: null,
    );
  }

  WorkerApplicationUpdateDto toWorkerApplicationUpdateDto(UserModel user) {
    return WorkerApplicationUpdateDto(
      applicationId: applicationId!,
      userId: user.userId,
      firstName: firstName,
      lastName: lastName,
      countryCode: country?.code,
      address: streetAddress,
      city: city,
      postalCode: zipCode,
      email: email,
      bank: iban?.let(
        (it) => BankInfoDto(
          countryCode: country?.code,
          clearingNumber: null,
          accountNumber: null,
          iban: iban,
        ),
      ),
      birthdate: birthday?.let(_applicationBirthdayFormatter.format),
      idCardUrls: [idFrontUrl, idBackUrl].mapNotNull((e) => e).toList(),
      selfie: selfieUrl,
      vehiclePlateUrls: [vehiclePlate].mapNotNull((e) => e).toList(),
      isApproved: null,
    );
  }
}

extension on DateFormat {
  DateTime? parseOrNull(String value) {
    try {
      return _applicationBirthdayFormatter.parse(value);
    } catch (ignore) {
      // That's life, sometime you win, other you lose
      return null;
    }
  }
}
