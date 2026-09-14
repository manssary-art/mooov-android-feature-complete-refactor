import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/riverpod_ext.dart';
import 'providers/_explore_providers.dart';
import 'widgets/content/explore_screen_content.dart';

class ExploreScreen extends HookConsumerWidget {
  final ValueSetter<String> onNavToOrderDetails;
  final VoidCallback onNavToProfile;
  final ValueSetter<String> onNavToExternalUrl;

  const ExploreScreen({
    super.key,
    required this.onNavToOrderDetails,
    required this.onNavToProfile,
    required this.onNavToExternalUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(exploreProvider);
    final initialNotifier = ref.watch(exploreProvider.notifier);
    final sideEffect = ref.watch(sideEffectProvider);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case ExploreSideEffect$NavToOrderDetails():
            onNavToOrderDetails(effect.orderId);
            break;
          case ExploreSideEffect$NavToProfile():
            onNavToProfile();
            break;
          case ExploreSideEffect$OpenUrl():
            onNavToExternalUrl(effect.url);
            break;
        }
      }).cancel,
      [sideEffect],
    );

    useEffect(() {
      initialNotifier.onPullToRefresh();
      return null;
    }, [initialNotifier]);

    final selectedTabNotifier = ref.watch(selectedTabProvider.notifier);
    final selectedTab = ref.watch(selectedTabProvider);

    if (initial.isLoading && !initial.hasValue) {
      return ExploreScreenContentLoading(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onValueChanged,
      );
    }

    if (initial.hasError) {
      return ExploreScreenContentError(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onValueChanged,
      );
    }

    final exploreAds = ref.watch(exploreAdsProvider);
    final exploreAdsNotifier = ref.watch(exploreAdsProvider.notifier);
    return ExploreScreenContentLoaded(
      selectedTab: selectedTab,
      onTabClicked: selectedTabNotifier.onValueChanged,
      items: initial.valueOrNull ?? [],
      isRefreshing: initial.isRefreshing,
      ads: exploreAds.valueOrNull,
      onPullToRefresh: initialNotifier.onPullToRefresh,
      onItemClicked: initialNotifier.onOrderClicked,
      onAdClicked: exploreAdsNotifier.onAdClicked,
    );
  }
}
