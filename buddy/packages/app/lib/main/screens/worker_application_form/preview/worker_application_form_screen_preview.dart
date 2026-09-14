import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../models/worker_application_form_status.dart';
import '../widgets/content/worker_application_form_screen_content.dart';

class WorkerApplicationFormScreenPreview extends HookWidget with PreviewMixin {
  WorkerApplicationFormScreenPreview({
    super.key,
  });

  @override
  String get name => 'WorkerApplicationFormScreen';

  @override
  Widget build(BuildContext context) {
    final firstName = useState('');
    final lastName = useState('');
    final email = useState('');
    final streetAddress = useState('');
    final zipCode = useState('');
    final city = useState('');
    final vehiclePlate = useState('');
    final iban = useState('');
    final companyName = useState('');
    final companyAddress = useState('');
    final companyVat = useState('');
    final companyTrafficPermit = useState(false);
    final birthday = useState<DateTime?>(null);
    final country = useState<Country?>(null);
    final idFront = useState<(XFile?, String?)>((null, null));
    final idBack = useState<(XFile?, String?)>((null, null));
    final selfie = useState<(XFile?, String?)>((null, null));
    final vehicle = useState<(XFile?, String?)>((null, null));

    return WorkerApplicationFormScreenContentLoaded(
      onNavBackClicked: () {},
      status: ApplicationStatus.approved,
      isSubmitButtonEnabled: true,
      firstName: firstName.value,
      onFirstNameChanged: firstName.onValueChanged,
      lastName: lastName.value,
      onLastNameChanged: lastName.onValueChanged,
      email: email.value,
      onEmailChanged: email.onValueChanged,
      streetAddress: streetAddress.value,
      onStreetAddressChanged: streetAddress.onValueChanged,
      zipCode: zipCode.value,
      onZipCodeChanged: zipCode.onValueChanged,
      city: city.value,
      onCityChanged: city.onValueChanged,
      vehiclePlate: vehiclePlate.value,
      onVehiclePlateChanged: vehiclePlate.onValueChanged,
      iban: iban.value,
      onIbanChanged: iban.onValueChanged,
      companyName: companyName.value,
      onCompanyNameChanged: companyName.onValueChanged,
      companyAddress: companyAddress.value,
      onCompanyAddressChanged: companyAddress.onValueChanged,
      companyVat: companyVat.value,
      onCompanyVatChanged: companyVat.onValueChanged,
      companyTrafficPermit: companyTrafficPermit.value,
      onCompanyTrafficPermitChanged: companyTrafficPermit.onValueChanged,
      country: country.value,
      onCountryClicked: () => country.value = Country.SE,
      birthday: birthday.value,
      onBirthdayClicked: () => birthday.value = DateTime.now(),
      idFront: idFront.value,
      onIdFrontClicked: () => idFront.value = (null, fakeImageUrl),
      idBack: idBack.value,
      onIdBackClicked: () => idBack.value = (null, fakeImageUrl),
      selfie: selfie.value,
      onSelfieClicked: () => selfie.value = (null, fakeImageUrl),
      vehicle: vehicle.value,
      onVehicleClicked: () => vehicle.value = (null, fakeImageUrl),
      onSubmitClicked: () {},
    );
  }
}
