part of '_profile_providers.dart';

final businessInfoProvider = NotifierProvider<ProfileBusinessInfoNotifier, UserModel?>(
  name: '$_name.businessInfoProvider',
  dependencies: _scope.dependencies,
  () => ProfileBusinessInfoNotifier(),
).scoped(_scope);

class ProfileBusinessInfoNotifier extends Notifier<UserModel?> {
  late final _userRepository = () => ref.read(userRepositoryProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);

  @override
  UserModel? build() {
    return ref.watch(profileProvider).valueOrNull;
  }

  void onOpenBusinessInfoClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToUpdateBusinessInfo());
  }

  void onSubmitBusinessInfoClicked(ProfileUpdateBusinessInfo$SubmitData data) async {
    try {
      _isWorkingNotifier().state = true;
      await _userRepository().setBusinessInfo(
        companyName: data.companyName,
        companyVat: data.companyVat,
        companyAddress: data.companyAddress,
        email: data.email,
      );
    } finally {
      _isWorkingNotifier().state = false;
    }
  }
}
