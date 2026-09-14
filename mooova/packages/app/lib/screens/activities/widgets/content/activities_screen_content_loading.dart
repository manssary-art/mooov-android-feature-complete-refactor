part of 'activities_screen_content.dart';

class ActivitiesScreenContentLoading extends HookWidget {
  final ActivitiesTab selectedTab;
  final void Function(ActivitiesTab) onTabClicked;

  const ActivitiesScreenContentLoading({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _ActivitiesScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
