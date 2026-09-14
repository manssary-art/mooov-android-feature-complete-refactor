part of '_profile_providers.dart';

final workerInfoProvider = NotifierProvider<ProfileWorkerInfoNotifier, UserModel?>(
  name: '$_name.workerInfoProvider',
  dependencies: _scope.dependencies,
  () => ProfileWorkerInfoNotifier(),
).scoped(_scope);

class ProfileWorkerInfoNotifier extends Notifier<UserModel?> {
  late final _userWorkerRepository = () => ref.read(userWorkerRepositoryProvider);
  late final _uploadRepository = () => ref.read(uploadRepositoryProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);

  @override
  UserModel? build() {
    return ref.watch(profileProvider).valueOrNull;
  }

  void onUpdateVehicleImageClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToVehicleImagePicker());
  }

  void onVehicleImagePicked(XFile file) async {
    try {
      _isWorkingNotifier().state = true;
      await _uploadRepository()
          .upload(file: file, type: UploadFolderType.vehicle)
          .flatMapValue((value) => _userWorkerRepository().setVehicleImage(imageUrl: value));
    } finally {
      _isWorkingNotifier().state = false;
    }
  }

  void onOpenWorkerApplicationFormClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToWorkerApplicationForm());
  }
}
