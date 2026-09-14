part of 'profile_screen_content.dart';

class ProfileScreenContentLoading extends HookWidget {
  final UserRole selectedTab;
  final void Function(UserRole) onTabClicked;

  const ProfileScreenContentLoading({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _ProfileScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
