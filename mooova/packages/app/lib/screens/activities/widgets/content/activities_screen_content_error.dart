part of 'activities_screen_content.dart';

class ActivitiesScreenContentError extends HookWidget {
  final ActivitiesTab selectedTab;
  final void Function(ActivitiesTab) onTabClicked;
  final void Function() onTryAgainClicked;

  const ActivitiesScreenContentError({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
    required this.onTryAgainClicked,
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
