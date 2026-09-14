part of 'order_details_screen_content.dart';

class OrderDetailsScreenContentLoaded extends HookWidget {
  final OrderModel order;
  final bool isWorking;
  final GeoPointModel? userLocation;
  final String? translatedDescription;
  final OrderDetailsDisplayMode displayMode;
  final VoidCallback onNavBackClicked;
  final Function(List<String> images, int index) onOrderImageClicked;
  final VoidCallback onShareClicked;
  final VoidCallback onEditClicked;
  final VoidCallback onTranslateClicked;
  final VoidCallback onDeleteOrderClicked;
  final ValueSetter<List<DateTime>> onApplyToOrderClicked;
  final VoidCallback onWithdrawApplyToOrderClicked;

  const OrderDetailsScreenContentLoaded({
    super.key,
    required this.order,
    required this.isWorking,
    required this.userLocation,
    required this.translatedDescription,
    required this.displayMode,
    required this.onNavBackClicked,
    required this.onOrderImageClicked,
    required this.onShareClicked,
    required this.onEditClicked,
    required this.onTranslateClicked,
    required this.onDeleteOrderClicked,
    required this.onApplyToOrderClicked,
    required this.onWithdrawApplyToOrderClicked,
  });

  @override
  Widget build(BuildContext context) {
    final openOnExternalMap = useOpenOnExternalMap();
    final copyToClipboard = useCopyToClipboard(context);
    return LoadingOverlay(
      isVisible: isWorking,
      child: _OrderDetailsScreenScaffold(
        onNavBackClicked: onNavBackClicked,
        body: SingleChildScrollView(
          child: Column(
            children: [
              OrderDetailsPageGallery(
                images: order.images ?? [],
                onImageClicked: (index) =>
                    onOrderImageClicked(order.images ?? [], index),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (displayMode is OrderDetailsDisplayMode$Owner &&
                              order.orderState == OrderState.created) ...[
                            Clickable(
                              onTap: onEditClicked,
                              child: OrderDetailsSmallButton(
                                icon: Icons.edit,
                                text: LocaleKeys.Edit.tr(),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (!kIsWeb) ...[
                            Clickable(
                              onTap: onShareClicked,
                              child: OrderDetailsSmallButton(
                                icon: Icons.share,
                                text: LocaleKeys.Share.tr(),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      OrderDetailsTimePicker(
                        orderState: order.orderState,
                        times: order.pickupTime ?? [],
                        displayMode: displayMode,
                        onApplyToOrderClicked: onApplyToOrderClicked,
                        onDeleteOrderClicked: onDeleteOrderClicked,
                        onWithdrawApplyToOrderClicked:
                            onWithdrawApplyToOrderClicked,
                      ),
                      if (order.orderType != OrderType.giveAway) ...[
                        const Divider(height: 80),
                        OrderDetailsPriceOffer(
                          currency: order.currency,
                          finalPrice: order.finalPrice,
                          estimatedPrice: order.estimatedPrice,
                        ),
                      ] else ...[
                        const Divider(height: 80),
                        OrderDetailsProductCondition(
                          productCondition: order.productCondition,
                        ),
                      ],
                      const Divider(height: 80),
                      OrderDetailsTranslatableDescription(
                        content:
                            translatedDescription ?? order.description ?? '',
                        title: order.orderType.let((it) {
                          switch (it) {
                            case OrderType.move:
                              return LocaleKeys.Move.tr();
                            case OrderType.buyForMe:
                              return LocaleKeys.BuyForMe.tr();
                            case OrderType.giveAway:
                              return LocaleKeys.GiveAway.tr();
                            case OrderType.fetchForMe:
                              return LocaleKeys.FetchForMe.tr();
                            case OrderType.recycle:
                              return LocaleKeys.Recycle.tr();
                          }
                        }),
                        onTranslateClicked: onTranslateClicked,
                      ),
                      const Divider(height: 40),
                      OrderDetailsNumOfWorkersRequested(
                        count: order.numOfWorkersRequested ?? 1,
                      ),
                      if (order.pickupAddress != null) ...[
                        const Divider(height: 40),
                        OrderDetailsMap(
                          category: order.orderType,
                          pickupAddress: order.pickupAddress!,
                          deliveryAddresses: order.deliveryAddresses ?? [],
                          userLocation: userLocation,
                        ),
                      ],
                      if (order.pickupAddress != null) ...[
                        const Divider(height: 40),
                        OrderDetailsAddress(
                          address: order.pickupAddress!,
                          displayMode: displayMode,
                          icon: Assets.images.iconMarkerPickUp,
                          title: LocaleKeys.PickupAddress.tr(),
                          onAddressClicked: copyToClipboard,
                          onNavigateClicked: () =>
                              openOnExternalMap(order.pickupAddress!),
                        ),
                      ],
                      if (order.pickupAddress != null) ...[
                        OrderDetailsDistance.realtime(
                          address: order.pickupAddress!,
                          userLocation: userLocation,
                          text: LocaleKeys.Distance.tr(),
                        )
                      ],
                      if (order.orderType != OrderType.giveAway &&
                          order.deliveryAddresses != null) ...[
                        for (final entry
                            in order.deliveryAddresses!.asMap().entries) ...[
                          const Divider(height: 40),
                          OrderDetailsAddress(
                            address: entry.value,
                            displayMode: displayMode,
                            icon: Assets.images.iconMarkerDropOff,
                            title: let(() {
                              switch (order.deliveryAddresses!.length) {
                                case 1:
                                  return LocaleKeys.DropOffAddress.tr();
                                default:
                                  return '${LocaleKeys.DeliveryAddress.tr()} ${entry.key + 1}';
                              }
                            }),
                            onAddressClicked: copyToClipboard,
                            onNavigateClicked: () =>
                                openOnExternalMap(entry.value),
                          ),
                        ],
                        if (order.totalDistance != null) ...[
                          const Divider(height: 80),
                          OrderDetailsDistance(
                            distance: order.totalDistance,
                            text: LocaleKeys.Distance.tr(),
                          ),
                        ],
                        const Divider(height: 80),
                        OrderDetailsOwnerUserProfile(
                          owner: order.owner,
                          displayMode: displayMode,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
