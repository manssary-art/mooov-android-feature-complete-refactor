part of '_profile_providers.dart';

final userInfoProvider = NotifierProvider<ProfileUserInfoNotifier, UserModel?>(
  name: '$_name.userInfoProvider',
  dependencies: _scope.dependencies,
  () => ProfileUserInfoNotifier(),
).scoped(_scope);

class ProfileUserInfoNotifier extends Notifier<UserModel?> {
  late final _userRepository = () => ref.read(userRepositoryProvider);
  late final _uploadRepository = () => ref.read(uploadRepositoryProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);

  @override
  UserModel? build() {
    return ref.watch(profileProvider).valueOrNull;
  }

  void onUpdateProfileImageClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToProfileImagePicker());
  }

  void onOpenUserInfoClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToUpdateUserInfo());
  }

  void onSubmitUserInfoClicked(ProfileUpdateUserInfo$SubmitData data) async {
    try {
      _isWorkingNotifier().state = true;
      await Future.wait([
        _userRepository().setUserInfo(
          firstName: data.firstName,
          lastName: data.lastName,
          email: data.email,
        ),
        _uploadRepository()
            .upload(file: data.pickedImage!, type: UploadFolderType.profile)
            .flatMapValue((value) => _userRepository().setUserProfileImage(imageUrl: value)),
      ]);
    } finally {
      _isWorkingNotifier().state = false;
    }
  }
}
