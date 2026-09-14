part of '_worker_application_form_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final statusProvider = Provider<ApplicationStatus>(
  name: '$_name.statusProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final value = ref.watch(workerApplicationFormProvider).valueOrNull;
    if (value != null && value.isApproved) return ApplicationStatus.approved;
    if (value != null && value.applicationId != null) return ApplicationStatus.submitted;
    return ApplicationStatus.notSubmitted;
  },
).scoped(_scope);

final isSubmitEnabledProvider = Provider<bool>(
  name: '$_name.isSubmitEnabledProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final status = ref.watch(statusProvider);
    final isWorking = ref.watch(isWorkingProvider);
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final email = ref.watch(emailProvider);
    final streetAddress = ref.watch(streetAddressProvider);
    final zipCode = ref.watch(zipCodeProvider);
    final city = ref.watch(cityProvider);
    final country = ref.watch(countryProvider);
    final iban = ref.watch(ibanProvider);
    final companyName = ref.watch(companyNameProvider);
    final companyVat = ref.watch(companyVatProvider);
    final companyAddress = ref.watch(companyAddressProvider);
    final birthday = ref.watch(birthdayProvider);
    final selfie = ref.watch(selfieProvider);
    final idFront = ref.watch(idFrontProvider);
    final idBack = ref.watch(idBackProvider);
    final vehicle = ref.watch(vehicleProvider);

    // if (status == ApplicationStatus.approved) return false;
    if (isWorking) return false;
    if (!firstName.isNotEmpty) return false;
    if (!lastName.isNotEmpty) return false;
    if (!email.isNotEmpty) return false;
    if (!email.isValidEmail) return false;
    if (birthday == null) return false;
    if (!streetAddress.isNotEmpty) return false;
    if (!zipCode.isNotEmpty) return false;
    if (!city.isNotEmpty) return false;
    if (country == null) return false;
    if (!iban.isNotEmpty) return false;
    if (!(idFront.$1 != null || idFront.$2 != null)) return false;
    if (!(idBack.$1 != null || idBack.$2 != null)) return false;
    if (!(selfie.$1 != null || selfie.$2 != null)) return false;
    if (!(vehicle.$1 != null || vehicle.$2 != null)) return false;
    if (!((companyName.isEmpty && companyVat.isEmpty && companyAddress.isEmpty) ||
        (companyName.isNotEmpty && companyVat.isNotEmpty && companyAddress.isNotEmpty))) return false;
    return true;
  },
).scoped(_scope);

final firstNameProvider = StateProvider<String>(
  name: '$_name.firstNameProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.firstName ?? '',
).scoped(_scope);

final lastNameProvider = StateProvider<String>(
  name: '$_name.lastNameProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.lastName ?? '',
).scoped(_scope);

final emailProvider = StateProvider<String>(
  name: '$_name.emailProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.email ?? '',
).scoped(_scope);

final birthdayProvider = StateProvider<DateTime?>(
  name: '$_name.birthdayProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.birthday,
).scoped(_scope);

final streetAddressProvider = StateProvider<String>(
  name: '$_name.streetAddressProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.streetAddress ?? '',
).scoped(_scope);

final zipCodeProvider = StateProvider<String>(
  name: '$_name.zipCodeProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.zipCode ?? '',
).scoped(_scope);

final cityProvider = StateProvider<String>(
  name: '$_name.cityProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.city ?? '',
).scoped(_scope);

final countryProvider = StateProvider<Country?>(
  name: '$_name.countryProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.country,
).scoped(_scope);

final vehiclePlateProvider = StateProvider<String>(
  name: '$_name.vehiclePlateProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.vehiclePlate ?? '',
).scoped(_scope);

final ibanProvider = StateProvider<String>(
  name: '$_name.ibanProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.iban ?? '',
).scoped(_scope);

final companyNameProvider = StateProvider<String>(
  name: '$_name.companyNameProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.businessInfo?.name ?? '',
).scoped(_scope);

final companyAddressProvider = StateProvider<String>(
  name: '$_name.companyAddressProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.businessInfo?.address ?? '',
).scoped(_scope);

final companyVatProvider = StateProvider<String>(
  name: '$_name.companyVatProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.businessInfo?.vatNumber ?? '',
).scoped(_scope);

final companyTrafficPermitProvider = StateProvider<bool>(
  name: '$_name.companyTrafficPermitProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(workerApplicationFormProvider).valueOrNull?.businessInfo?.hasTrafficPermit ?? false,
).scoped(_scope);

final idFrontProvider = StateProvider<(XFile?, String?)>(
  name: '$_name.idFrontProvider',
  dependencies: _scope.dependencies,
  (ref) => (null, ref.watch(workerApplicationFormProvider).valueOrNull?.idFrontUrl),
).scoped(_scope);

final idBackProvider = StateProvider<(XFile?, String?)>(
  name: '$_name.idBackProvider',
  dependencies: _scope.dependencies,
  (ref) => (null, ref.watch(workerApplicationFormProvider).valueOrNull?.idBackUrl),
).scoped(_scope);

final selfieProvider = StateProvider<(XFile?, String?)>(
  name: '$_name.selfieProvider',
  dependencies: _scope.dependencies,
  (ref) => (null, ref.watch(workerApplicationFormProvider).valueOrNull?.selfieUrl),
).scoped(_scope);

final vehicleProvider = StateProvider<(XFile?, String?)>(
  name: '$_name.vehicleProvider',
  dependencies: _scope.dependencies,
  (ref) => (null, ref.watch(workerApplicationFormProvider).valueOrNull?.vehicleUrl),
).scoped(_scope);
