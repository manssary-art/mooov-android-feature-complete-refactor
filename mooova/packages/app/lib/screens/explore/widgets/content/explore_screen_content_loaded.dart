part of 'explore_screen_content.dart';

class ExploreScreenContentLoaded extends HookWidget {
  final ValueListenable<ExploreTab> selectedTab;
  final ValueListenable<List<OrderModel>> items;
  final ValueListenable<bool> isRefreshing;
  final ValueListenable<ExploreAdsModel?> ads;

  /// Common Actions

  final Function() onPullToRefresh;
  final Function(String orderId) onItemClicked;
  final void Function(ExploreTab) onTabClicked;
  final void Function(ExploreAdModelAction) onAdClicked;

  const ExploreScreenContentLoaded({
    super.key,
    required this.items,
    required this.ads,
    required this.isRefreshing,
    required this.selectedTab,
    required this.onTabClicked,
    required this.onItemClicked,
    required this.onPullToRefresh,
    required this.onAdClicked,
  });

  @override
  Widget build(BuildContext context) {
    final selectedTab = useValueListenable(this.selectedTab);
    final items = useValueListenable(this.items);
    final allItems = items;
    final newItems = useMemoized(() => items.where((e) => e.orderState == OrderState.created).toList(), [items]);
    return _ExploreScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: IndexedStack(
        index: ExploreTab.values.indexOf(selectedTab),
        children: [
          for (final tabItems in [allItems, newItems].asMap().values) ...[
            buildTabContent(items: tabItems),
          ]
        ],
      ),
    );
  }

  Widget buildTabContent({
    required List<OrderModel> items,
  }) =>
      HookBuilder(
        builder: (context) {
          final isRefreshing = useValueListenable(this.isRefreshing);
          final ads = useValueListenable(this.ads);
          final awaitWhileRefreshing = useAwaitWhile(isRefreshing);
          final adsList = useMemoized(() {
            final locale = context.locale.languageCode;
            final content = ads?.content ?? const [];
            return content.where((e) => e.locale == null || e.locale.equalsOther(locale, ignoreCase: true)).toList();
          }, [ads]);

          return PullToRefresh(
            onRefresh: () async {
              onPullToRefresh();
              await awaitWhileRefreshing();
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final order = items[index];
                return Clickable(
                  onTap: () => onItemClicked(order.orderId),
                  child: ExploreOrderListItem(
                    order: order,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                final shouldDisplay = ads?.let((it) => index != 0 && index % it.gap == 0) ?? false;
                final ad = adsList.takeIf((it) => shouldDisplay && it.isNotEmpty)?.let((it) => it[index % it.length]);
                if (ad != null) {
                  return Column(
                    children: [
                      const Divider(),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveBreakpoints.of(context).breakpointOfOrNull(MOBILE)?.end ?? 450,
                        ),
                        child: Clickable(
                          onTap: () => ad.action != null ? onAdClicked(ad.action!) : null,
                          child: ExploreAdListItem(ad: ad),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                } else {
                  return const Divider();
                }
              },
            ),
          );
        },
      );
}
