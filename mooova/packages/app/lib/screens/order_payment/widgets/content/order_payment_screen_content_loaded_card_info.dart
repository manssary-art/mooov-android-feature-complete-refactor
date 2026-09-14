part of 'order_payment_screen_content.dart';

class OrderPaymentScreenContentLoadedCardInfo extends HookWidget {
  final VoidCallback onNavBackClicked;
  final ValueListenable<String?> cardNumber;
  final ValueListenable<String?> cvc;
  final ValueListenable<String?> expMonth;
  final ValueListenable<String?> expYear;
  final ValueListenable<bool> isSaveCardEnabled;
  final void Function(bool) onSaveCardChanged;
  final void Function(String?) onCardNumberChanged;
  final void Function(String?) onCvcNumberChanged;
  final void Function(String?) onExpMonthChanged;
  final void Function(String?) onExpYearChanged;
  final void Function() onSubmitClicked;

  const OrderPaymentScreenContentLoadedCardInfo({
    super.key,
    required this.cardNumber,
    required this.cvc,
    required this.expMonth,
    required this.expYear,
    required this.isSaveCardEnabled,
    required this.onNavBackClicked,
    required this.onSubmitClicked,
    required this.onSaveCardChanged,
    required this.onCardNumberChanged,
    required this.onCvcNumberChanged,
    required this.onExpMonthChanged,
    required this.onExpYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cardNumber = useValueListenable(this.cardNumber);
    final cvc = useValueListenable(this.cvc);
    final expMonth = useValueListenable(this.expMonth);
    final expYear = useValueListenable(this.expYear);
    final isSaveCardEnabled = useValueListenable(this.isSaveCardEnabled);
    return _OrderPaymentScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys.PayTheOrder.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(height: 16),
                Text(
                  LocaleKeys.FillCard.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                OrderPaymentCardInfoField(
                  cardNumber: cardNumber,
                  cvc: cvc,
                  expMonth: expMonth,
                  expYear: expYear,
                  onCardNumberChanged: onCardNumberChanged,
                  onCvcChanged: onCvcNumberChanged,
                  onExpMonthChanged: onExpMonthChanged,
                  onExpYearChanged: onExpYearChanged,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.SaveThisCard.tr()),
                    Switch(
                      value: isSaveCardEnabled,
                      activeTrackColor: ColorName.success,
                      onChanged: onSaveCardChanged,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: FilledButton(
                    onPressed: onSubmitClicked,
                    child: Text(LocaleKeys.Confirm.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
