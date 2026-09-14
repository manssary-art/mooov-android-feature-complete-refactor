import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/riverpod_ext.dart';
import '../../hooks/flutter_hooks.dart';
import 'providers/_worker_application_form_providers.dart';
import 'widgets/content/worker_application_form_screen_content.dart';

class WorkerApplicationFormScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;
  final Future<XFile?> Function() onNavToImagePicker;
  final Future<Country?> Function(Country? initial) onNavToCountryPicker;
  final Future<DateTime?> Function(DateTime? initial) onNavToDatePicker;

  const WorkerApplicationFormScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToCountryPicker,
    required this.onNavToImagePicker,
    required this.onNavToDatePicker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        workerApplicationFormProvider.overrideWith(() => WorkerApplicationFormNotifier()),
      ],
      child: _WorkerApplicationFormScreen(
        onNavBack: onNavBack,
        onNavToCountryPicker: onNavToCountryPicker,
        onNavToImagePicker: onNavToImagePicker,
        onNavToDatePicker: onNavToDatePicker,
      ),
    );
  }
}

class _WorkerApplicationFormScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;
  final Future<XFile?> Function() onNavToImagePicker;
  final Future<Country?> Function(Country? initial) onNavToCountryPicker;
  final Future<DateTime?> Function(DateTime? initial) onNavToDatePicker;

  const _WorkerApplicationFormScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToCountryPicker,
    required this.onNavToImagePicker,
    required this.onNavToDatePicker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSnackBar = useShowSnackBar(context);
    final initial = ref.watch(workerApplicationFormProvider);
    final initialNotifier = ref.watch(workerApplicationFormProvider.notifier);
    final sideEffect = ref.watch(sideEffectProvider);

    final submitNotifier = ref.watch(submitProvider.notifier);
    final isSubmitEnabled = ref.watch(isSubmitEnabledProvider);
    final isWorking = ref.watch(isWorkingProvider);
    final status = ref.watch(statusProvider);
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final email = ref.watch(emailProvider);
    final streetAddress = ref.watch(streetAddressProvider);
    final zipCode = ref.watch(zipCodeProvider);
    final city = ref.watch(cityProvider);
    final vehiclePlate = ref.watch(vehiclePlateProvider);
    final country = ref.watch(countryProvider);
    final iban = ref.watch(ibanProvider);
    final companyName = ref.watch(companyNameProvider);
    final companyVat = ref.watch(companyVatProvider);
    final companyAddress = ref.watch(companyAddressProvider);
    final companyTrafficPermit = ref.watch(companyTrafficPermitProvider);
    final birthday = ref.watch(birthdayProvider);
    final selfie = ref.watch(selfieProvider);
    final idFront = ref.watch(idFrontProvider);
    final idBack = ref.watch(idBackProvider);
    final vehicle = ref.watch(vehicleProvider);

    final firstNameNotifier = ref.watch(firstNameProvider.notifier);
    final lastNameNotifier = ref.watch(lastNameProvider.notifier);
    final emailNotifier = ref.watch(emailProvider.notifier);
    final streetAddressNotifier = ref.watch(streetAddressProvider.notifier);
    final zipCodeNotifier = ref.watch(zipCodeProvider.notifier);
    final cityNotifier = ref.watch(cityProvider.notifier);
    final vehiclePlateNotifier = ref.watch(vehiclePlateProvider.notifier);
    final countryNotifier = ref.watch(countryProvider.notifier);
    final ibanNotifier = ref.watch(ibanProvider.notifier);
    final companyNameNotifier = ref.watch(companyNameProvider.notifier);
    final companyVatNotifier = ref.watch(companyVatProvider.notifier);
    final companyAddressNotifier = ref.watch(companyAddressProvider.notifier);
    final companyTrafficPermitNotifier = ref.watch(companyTrafficPermitProvider.notifier);
    final birthdayNotifier = ref.watch(birthdayProvider.notifier);
    final selfieNotifier = ref.watch(selfieProvider.notifier);
    final idFrontNotifier = ref.watch(idFrontProvider.notifier);
    final idBackNotifier = ref.watch(idBackProvider.notifier);
    final vehicleNotifier = ref.watch(vehicleProvider.notifier);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case WorkerApplicationFormSideEffect$NavToBack():
            onNavBack();
            break;
          case WorkerApplicationFormSideEffect$ShowErrorMessage():
            showSnackBar(effect.value);
            break;
        }
      }).cancel,
      [sideEffect],
    );

    if (initial.isLoading && !initial.hasValue) {
      return WorkerApplicationFormScreenContentLoading(
        onNavBackClicked: onNavBack,
      );
    }

    if (initial.hasError) {
      return WorkerApplicationFormScreenContentError(
        error: initial.error,
        onNavBackClicked: onNavBack,
        onTryAgainClicked: initialNotifier.onTryAgainClicked,
      );
    }

    return LoadingOverlay(
      isVisible: isWorking,
      child: WorkerApplicationFormScreenContentLoaded(
        onNavBackClicked: onNavBack,
        status: status,
        isSubmitButtonEnabled: isSubmitEnabled,
        firstName: firstName,
        onFirstNameChanged: firstNameNotifier.onValueChanged,
        lastName: lastName,
        onLastNameChanged: lastNameNotifier.onValueChanged,
        email: email,
        onEmailChanged: emailNotifier.onValueChanged,
        streetAddress: streetAddress,
        onStreetAddressChanged: streetAddressNotifier.onValueChanged,
        zipCode: zipCode,
        onZipCodeChanged: zipCodeNotifier.onValueChanged,
        city: city,
        onCityChanged: cityNotifier.onValueChanged,
        vehiclePlate: vehiclePlate,
        onVehiclePlateChanged: vehiclePlateNotifier.onValueChanged,
        iban: iban,
        onIbanChanged: ibanNotifier.onValueChanged,
        companyName: companyName,
        onCompanyNameChanged: companyNameNotifier.onValueChanged,
        companyAddress: companyAddress,
        onCompanyAddressChanged: companyAddressNotifier.onValueChanged,
        companyVat: companyVat,
        onCompanyVatChanged: companyVatNotifier.onValueChanged,
        companyTrafficPermit: companyTrafficPermit,
        onCompanyTrafficPermitChanged: companyTrafficPermitNotifier.onValueChanged,
        country: country,
        onCountryClicked: () async {
          final value = await onNavToCountryPicker(country);
          if (value != null) {
            countryNotifier.onValueChanged(value);
          }
        },
        birthday: birthday,
        onBirthdayClicked: () async {
          final value = await onNavToDatePicker(birthday);
          if (value != null) {
            birthdayNotifier.onValueChanged(value);
          }
        },
        idFront: idFront,
        onIdFrontClicked: () async {
          final value = await onNavToImagePicker();
          if (value != null) {
            idFrontNotifier.onValueChanged((value, idFront.$2));
          }
        },
        idBack: idBack,
        onIdBackClicked: () async {
          final value = await onNavToImagePicker();
          if (value != null) {
            idBackNotifier.onValueChanged((value, idBack.$2));
          }
        },
        selfie: selfie,
        onSelfieClicked: () async {
          final value = await onNavToImagePicker();
          if (value != null) {
            selfieNotifier.onValueChanged((value, selfie.$2));
          }
        },
        vehicle: vehicle,
        onVehicleClicked: () async {
          final value = await onNavToImagePicker();
          if (value != null) {
            vehicleNotifier.onValueChanged((value, vehicle.$2));
          }
        },
        onSubmitClicked: submitNotifier.onSubmitClicked,
      ),
    );
  }
}
