part of 'profile_screen_content.dart';

class ProfileScreenContentLoaded extends HookWidget {
  final UserRole selectedTab;
  final void Function(UserRole) onTabClicked;

  final UserModel user;
  final void Function() onOpenUserInfoClicked;
  final void Function() onUpdateVehicleImageClicked;
  final void Function() onSignOutClicked;
  final void Function() onShareClicked;
  final void Function() onImageShareClicked;
  final void Function() onOpenSavedCardClicked;
  final void Function() onOpenNotificationSettingsClicked;
  final void Function() onOpenWorkerApplicationFormClicked;
  final void Function() onOpenBusinessInfoClicked;

  const ProfileScreenContentLoaded({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
    required this.user,
    required this.onOpenUserInfoClicked,
    required this.onUpdateVehicleImageClicked,
    required this.onSignOutClicked,
    required this.onShareClicked,
    required this.onImageShareClicked,
    required this.onOpenSavedCardClicked,
    required this.onOpenNotificationSettingsClicked,
    required this.onOpenWorkerApplicationFormClicked,
    required this.onOpenBusinessInfoClicked,
  });

  @override
  Widget build(BuildContext context) {
    final userPerspective = useMemoized(() => user.copyWith(role: () => UserRole.user), [user]);
    final workerPerspective = useMemoized(() => user.copyWith(role: () => UserRole.worker), [user]);
    return _ProfileScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: SingleChildScrollView(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: SafeArea(
            child: let(() => switch (selectedTab) {
                  UserRole.user => _ProfileScreenContentLoadedUser(
                      key: const ValueKey(UserRole.user),
                      user: userPerspective,
                      onOpenUserInfoClicked: onOpenUserInfoClicked,
                      onUpdateVehicleImageClicked: onUpdateVehicleImageClicked,
                      onImageShareClicked: onImageShareClicked,
                      onShareClicked: onShareClicked,
                      onSignOutClicked: onSignOutClicked,
                      onOpenSavedCardClicked: onOpenSavedCardClicked,
                      onOpenNotificationSettingsClicked: onOpenNotificationSettingsClicked,
                      onOpenWorkerApplicationFormClicked: onOpenWorkerApplicationFormClicked,
                      onOpenBusinessInfoClicked: onOpenBusinessInfoClicked,
                    ),
                  UserRole.worker => _ProfileScreenContentLoadedUser(
                      key: const ValueKey(UserRole.worker),
                      user: workerPerspective,
                      onOpenUserInfoClicked: onOpenUserInfoClicked,
                      onUpdateVehicleImageClicked: onUpdateVehicleImageClicked,
                      onImageShareClicked: onImageShareClicked,
                      onShareClicked: onShareClicked,
                      onSignOutClicked: onSignOutClicked,
                      onOpenSavedCardClicked: onOpenSavedCardClicked,
                      onOpenNotificationSettingsClicked: onOpenNotificationSettingsClicked,
                      onOpenWorkerApplicationFormClicked: onOpenWorkerApplicationFormClicked,
                      onOpenBusinessInfoClicked: onOpenBusinessInfoClicked,
                    )
                }),
          ),
        ),
      ),
    );
  }
}

class _ProfileScreenContentLoadedUser extends HookWidget {
  final UserModel user;
  final void Function() onOpenUserInfoClicked;
  final void Function() onUpdateVehicleImageClicked;
  final void Function() onSignOutClicked;
  final void Function() onShareClicked;
  final void Function() onImageShareClicked;
  final void Function() onOpenSavedCardClicked;
  final void Function() onOpenNotificationSettingsClicked;
  final void Function() onOpenWorkerApplicationFormClicked;
  final void Function() onOpenBusinessInfoClicked;

  const _ProfileScreenContentLoadedUser({
    super.key,
    required this.user,
    required this.onOpenUserInfoClicked,
    required this.onUpdateVehicleImageClicked,
    required this.onSignOutClicked,
    required this.onShareClicked,
    required this.onImageShareClicked,
    required this.onOpenSavedCardClicked,
    required this.onOpenNotificationSettingsClicked,
    required this.onOpenWorkerApplicationFormClicked,
    required this.onOpenBusinessInfoClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: ProfileUserInfoHeader(
            user: user,
            onOpenUserInfoClicked: onOpenUserInfoClicked,
            onUpdateVehicleImageClicked: onUpdateVehicleImageClicked,
          ),
        ),
        const Divider(),
        if (user.role == UserRole.worker) ...[
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              LocaleKeys.MoooverProfileDes.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        if (user.referralInfo != null && user.referralInfo!.referralCode != null) ...[
          Padding(
            padding: const EdgeInsets.all(24),
            child: ProfileShareCard(
              payload: user.referralInfo!.referralCode,
              country: user.country,
              role: user.role,
              onShareClicked: onShareClicked,
              onImageShareClicked: onImageShareClicked,
            ),
          ),
        ],
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(24),
          child: ProfileUserStatistics(
            user: user,
          ),
        ),
        if (user.role == UserRole.user) ...[
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ProfileUserScoreTags(
              user: user,
            ),
          ),
        ],
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ProfileOptionButtons(
            user: user,
            onOpenSavedCardClicked: onOpenSavedCardClicked,
            onOpenNotificationSettingsClicked: onOpenNotificationSettingsClicked,
            onOpenWorkerApplicationFormClicked: onOpenWorkerApplicationFormClicked,
            onOpenBusinessInfoClicked: onOpenBusinessInfoClicked,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: ProfileIceBanner(),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: ProfileSocialFooter(onSignOutClicked: onSignOutClicked),
        ),
      ],
    );
  }
}
