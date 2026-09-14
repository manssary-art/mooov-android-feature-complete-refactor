part of 'explore_screen_content.dart';

class ExploreScreenContentError extends HookWidget {
  final ExploreTab selectedTab;
  final void Function(ExploreTab) onTabClicked;

  const ExploreScreenContentError({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _ExploreScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
