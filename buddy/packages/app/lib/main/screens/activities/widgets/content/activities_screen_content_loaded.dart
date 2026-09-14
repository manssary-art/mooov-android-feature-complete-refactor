part of 'activities_screen_content.dart';

class ActivitiesScreenContentLoaded extends HookWidget {
  final ActivitiesTab selectedTab;
  final List<ActivitiesOrderItem> items;
  final bool isRefreshing;

  /// Common Actions

  final Function() onPullToRefresh;
  final Function(String orderId) onItemClicked;
  final void Function(ActivitiesTab) onTabClicked;

  /// Owner actions

  final Function(String orderId) onOwnerEmailSupportClicked;
  final Function(String orderId) onOwnerIncreasePriceClicked;
  final Function(String orderId) onOwnerSelectCandidateClicked;
  final Function(String orderId) onOwnerPhoneCallWorkerClicked;
  final Function(String orderId) onOwnerPhoneSmsWorkerClicked;
  final Function(String orderId) onOwnerDeliveryDoneClicked;
  final Function(String orderId) onOwnerRateOrderClicked;
  final Function(String orderId) onOwnerRenewOrderClicked;

  /// Worker actions

  final Function(String orderId) onWorkerPhoneCallOwnerClicked;
  final Function(String orderId) onWorkerPhoneSmsOwnerClicked;
  final Function(String orderId) onWorkerUploadPickedUpImageClicked;
  final Function(String orderId) onWorkerUploadDeliveredImageClicked;
  final Function(String orderId) onWorkerCancelAndRefundClicked;
  final Function(String orderId) onWorkerDeliveryDoneClicked;
  final Function(String orderId) onWorkerEmailSupportClicked;

  const ActivitiesScreenContentLoaded({
    super.key,
    required this.items,
    required this.isRefreshing,
    required this.selectedTab,
    required this.onTabClicked,
    required this.onItemClicked,
    required this.onPullToRefresh,
    required this.onOwnerIncreasePriceClicked,
    required this.onOwnerEmailSupportClicked,
    required this.onOwnerSelectCandidateClicked,
    required this.onOwnerPhoneCallWorkerClicked,
    required this.onOwnerPhoneSmsWorkerClicked,
    required this.onOwnerDeliveryDoneClicked,
    required this.onOwnerRateOrderClicked,
    required this.onOwnerRenewOrderClicked,
    required this.onWorkerPhoneCallOwnerClicked,
    required this.onWorkerPhoneSmsOwnerClicked,
    required this.onWorkerUploadPickedUpImageClicked,
    required this.onWorkerUploadDeliveredImageClicked,
    required this.onWorkerCancelAndRefundClicked,
    required this.onWorkerDeliveryDoneClicked,
    required this.onWorkerEmailSupportClicked,
  });

  @override
  Widget build(BuildContext context) {
    final availableItems = useMemoized(() => items.where((e) => !e.isCompleted).toList(), [items]);
    final completedItems = useMemoized(() => items.where((e) => e.isCompleted).toList(), [items]);
    return _ActivitiesScreenScaffold(
      selectedTab: selectedTab,
      onTabClicked: onTabClicked,
      body: IndexedStack(
        index: ActivitiesTab.values.indexOf(selectedTab),
        children: [
          for (final tabItems in [availableItems, completedItems].asMap().values) ...[
            buildTabContent(items: tabItems),
          ]
        ],
      ),
    );
  }

  Widget buildTabContent({
    required List<ActivitiesOrderItem> items,
  }) =>
      HookBuilder(
        builder: (context) {
          final awaitWhileRefreshing = useAwaitWhile(isRefreshing);
          final openOnExternalMap = useOpenOnExternalMap();
          final copyToClipboard = useCopyToClipboard(context);

          if (items.isEmpty) {
            return const ActivitiesContentEmpty();
          }

          return PullToRefresh(
            onRefresh: () async {
              onPullToRefresh();
              await awaitWhileRefreshing();
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Material(
                  elevation: 16,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ActivitiesItemContent(
                      item: item,
                      onItemClicked: () => onItemClicked(item.order.orderId),
                      onCopyAddressClicked: copyToClipboard,
                      onNavigateClicked: openOnExternalMap,
                      onOwnerIncreasePriceClicked: () => onOwnerIncreasePriceClicked(item.order.orderId),
                      onOwnerEmailSupportClicked: () => onOwnerEmailSupportClicked(item.order.orderId),
                      onOwnerSelectCandidateClicked: () => onOwnerSelectCandidateClicked(item.order.orderId),
                      onOwnerPhoneCallWorkerClicked: () => onOwnerPhoneCallWorkerClicked(item.order.orderId),
                      onOwnerPhoneSmsWorkerClicked: () => onOwnerPhoneSmsWorkerClicked(item.order.orderId),
                      onOwnerDeliveryDoneClicked: () => onOwnerDeliveryDoneClicked(item.order.orderId),
                      onOwnerRateOrderClicked: () => onOwnerRateOrderClicked(item.order.orderId),
                      onOwnerRenewOrderClicked: () => onOwnerRenewOrderClicked(item.order.orderId),
                      onWorkerPhoneCallOwnerClicked: () => onWorkerPhoneCallOwnerClicked(item.order.orderId),
                      onWorkerPhoneSmsOwnerClicked: () => onWorkerPhoneSmsOwnerClicked(item.order.orderId),
                      onWorkerUploadPickedUpImageClicked: () => onWorkerUploadPickedUpImageClicked(item.order.orderId),
                      onWorkerUploadDeliveredImageClicked: () =>
                          onWorkerUploadDeliveredImageClicked(item.order.orderId),
                      onWorkerCancelAndRefundClicked: () => onWorkerCancelAndRefundClicked(item.order.orderId),
                      onWorkerDeliveryDoneClicked: () => onWorkerDeliveryDoneClicked(item.order.orderId),
                      onWorkerEmailSupportClicked: () => onWorkerEmailSupportClicked(item.order.orderId),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
          );
        },
      );
}
