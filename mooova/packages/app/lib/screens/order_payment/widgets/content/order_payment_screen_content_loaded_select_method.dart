part of 'order_payment_screen_content.dart';

class OrderPaymentScreenContentLoadedSelectMethod extends HookWidget {
  final VoidCallback onNavBackClicked;
  final ValueListenable<String> promoCode;
  final ValueListenable<Money> amount;
  final ValueListenable<Money?> discount;
  final ValueListenable<Currency> currency;
  final ValueListenable<bool> isApplyingPromoCode;
  final ValueListenable<List<AvailablePaymentMethod>> availableMethods;
  final void Function(String) onPromoCodeChanged;
  final void Function(AvailablePaymentMethod) onPaymentMethodClicked;

  const OrderPaymentScreenContentLoadedSelectMethod({
    super.key,
    required this.promoCode,
    required this.amount,
    required this.currency,
    required this.discount,
    required this.isApplyingPromoCode,
    required this.availableMethods,
    required this.onNavBackClicked,
    required this.onPromoCodeChanged,
    required this.onPaymentMethodClicked,
  });

  @override
  Widget build(BuildContext context) {
    final availableMethods = useValueListenable(this.availableMethods);
    return _OrderPaymentScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                OrderPaymentPromoCodeField(
                  promoCode: promoCode,
                  amount: amount,
                  discount: discount,
                  currency: currency,
                  isApplyingPromoCode: isApplyingPromoCode,
                  onPromoCodeChanged: onPromoCodeChanged,
                ),
                const SizedBox(height: 16),
                for (final method in availableMethods) ...[
                  OrderPaymentAvailableMethodListItem(
                    onTap: () => onPaymentMethodClicked(method),
                    text: switch (method) {
                      AvailablePaymentMethod$Klarna() => 'Klarna',
                      AvailablePaymentMethod$Card() => LocaleKeys.CardPayment.tr(),
                      AvailablePaymentMethod$SavedCard() => '******${method.info.last4}',
                    },
                    image: switch (method) {
                      AvailablePaymentMethod$Klarna() => Assets.images.iconKlarna,
                      AvailablePaymentMethod$Card() => Assets.images.iconCard,
                      AvailablePaymentMethod$SavedCard() => method.info.brand.cardBrandAsset,
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
