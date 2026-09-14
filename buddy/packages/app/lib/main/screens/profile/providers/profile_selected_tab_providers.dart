part of '_profile_providers.dart';

final selectedTabProvider = NotifierProvider<ProfileSelectedTabNotifier, UserRole>(
  name: '$_name.selectedTabProvider',
  dependencies: _scope.dependencies,
  () => ProfileSelectedTabNotifier(),
).scoped(_scope);

class ProfileSelectedTabNotifier extends Notifier<UserRole> {
  late final _user = () => ref.read(profileProvider).valueOrNull;
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  UserRole build() {
    ref.listen(profileProvider, (previous, next) {
      final initial = next.valueOrNull;
      if (initial != null && initial.role != UserRole.worker && state != UserRole.user) {
        state = UserRole.user;
      }
    });

    return UserRole.user;
  }

  void onTabChanged(UserRole tab) async {
    final user = _user();
    if (user != null && user.role != UserRole.worker && tab == UserRole.worker) {
      _sideEffect().add(const ProfileSideEffect$NavToWorkerApplicationForm());
    } else {
      state = tab;
    }
  }
}
