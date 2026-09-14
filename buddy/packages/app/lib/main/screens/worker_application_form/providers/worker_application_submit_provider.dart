part of '_worker_application_form_providers.dart';

final submitProvider = NotifierProvider<WorkerApplicationSubmitNotifier, void>(
  name: '$_name.workerApplicationFormProvider',
  dependencies: _scope.dependencies,
  () => WorkerApplicationSubmitNotifier(),
).scoped(_scope);

class WorkerApplicationSubmitNotifier extends Notifier<void> {
  late final _initial = () => ref.read(workerApplicationFormProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _userWorkerRepository = () => ref.read(userWorkerRepositoryProvider);
  late final _uploadRepository = () => ref.read(uploadRepositoryProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);
  late final _firstName = () => ref.read(firstNameProvider);
  late final _lastName = () => ref.read(lastNameProvider);
  late final _email = () => ref.read(emailProvider);
  late final _streetAddress = () => ref.read(streetAddressProvider);
  late final _zipCode = () => ref.read(zipCodeProvider);
  late final _city = () => ref.read(cityProvider);
  late final _country = () => ref.read(countryProvider);
  late final _iban = () => ref.read(ibanProvider);
  late final _companyName = () => ref.read(companyNameProvider);
  late final _companyVat = () => ref.read(companyVatProvider);
  late final _companyAddress = () => ref.read(companyAddressProvider);
  late final _companyTrafficPermit = () => ref.read(companyTrafficPermitProvider);
  late final _birthday = () => ref.read(birthdayProvider);
  late final _selfieNotifier = () => ref.read(selfieProvider.notifier);
  late final _idFrontNotifier = () => ref.read(idFrontProvider.notifier);
  late final _idBackNotifier = () => ref.read(idBackProvider.notifier);
  late final _vehicleNotifier = () => ref.read(vehicleProvider.notifier);
  late final _isSubmitEnabled = () => ref.read(isSubmitEnabledProvider);

  @override
  void build() {}

  void onSubmitClicked() async {
    final value = _initial().valueOrNull;
    if (value == null || !_isSubmitEnabled()) {
      return;
    }

    try {
      _isWorkingNotifier().state = true;
      final selfieUrl = await _selfieNotifier()
          .state
          .let((it) {
            if (it.$1 == null && it.$2 != null) return Future.value(Result<String>.value(it.$2!));
            return _uploadRepository()
                .upload(file: it.$1!, type: UploadFolderType.profile)
                .onValue((e) => _selfieNotifier().state = (it.$1, e))
                .onError((e, _) => _sideEffect()
                    .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to upload selfie image')));
          })
          .asValue
          .value;

      if (selfieUrl == null) {
        return;
      }

      final idFrontUrl = await _idFrontNotifier()
          .state
          .let((it) {
            if (it.$1 == null && it.$2 != null) return Future.value(Result<String>.value(it.$2!));
            return _uploadRepository()
                .upload(file: it.$1!, type: UploadFolderType.document)
                .onValue((e) => _idFrontNotifier().state = (it.$1, e))
                .onError((e, _) => _sideEffect()
                    .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to upload id-front image')));
          })
          .asValue
          .value;

      if (idFrontUrl == null) {
        return;
      }

      final idBackUrl = await _idBackNotifier()
          .state
          .let((it) {
            if (it.$1 == null && it.$2 != null) return Future.value(Result<String>.value(it.$2!));
            return _uploadRepository()
                .upload(file: it.$1!, type: UploadFolderType.document)
                .onValue((e) => _idBackNotifier().state = (it.$1, e))
                .onError((e, _) => _sideEffect()
                    .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to upload id-back image')));
          })
          .asValue
          .value;

      if (idBackUrl == null) {
        return;
      }

      final vehicleUrl = await _vehicleNotifier()
          .state
          .let((it) {
            if (it.$1 == null && it.$2 != null) return Future.value(Result<String>.value(it.$2!));
            return _uploadRepository()
                .upload(file: it.$1!, type: UploadFolderType.vehicle)
                .onValue((e) => _vehicleNotifier().state = (it.$1, e))
                .onError((e, _) => _sideEffect()
                    .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to upload vehicle image')));
          })
          .asValue
          .value;

      if (vehicleUrl == null) {
        return;
      }

      final form = value.copyWith(
        firstName: _firstName().copy,
        lastName: _lastName().copy,
        email: _email().copy,
        streetAddress: _streetAddress().copy,
        zipCode: _zipCode().copy,
        city: _city().copy,
        country: _country().copy,
        iban: _iban().copy,
        businessInfo: UserInfoBusinessModel(
          name: _companyName(),
          vatNumber: _companyVat(),
          address: _companyAddress(),
          hasTrafficPermit: _companyTrafficPermit(),
        ).copy,
        birthday: _birthday().copy,
        selfieUrl: selfieUrl.copy,
        idFrontUrl: idFrontUrl.copy,
        idBackUrl: idBackUrl.copy,
        vehicleUrl: vehicleUrl.copy,
      );

      if (value.applicationId != null) {
        await _userWorkerRepository()
            .updateApplicationForm(form: form)
            .onValue((e) => _sideEffect().add(const WorkerApplicationFormSideEffect$NavToBack()))
            .onError((e, _) => _sideEffect()
                .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to update application')));
      } else {
        await _userWorkerRepository()
            .createApplicationForm(form: form)
            .onValue((e) => _sideEffect().add(const WorkerApplicationFormSideEffect$NavToBack()))
            .onError((e, _) => _sideEffect()
                .add(const WorkerApplicationFormSideEffect$ShowErrorMessage('Failed to send application')));
      }
    } finally {
      _isWorkingNotifier().state = false;
    }
  }
}
