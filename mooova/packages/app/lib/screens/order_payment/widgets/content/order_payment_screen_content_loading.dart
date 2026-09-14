part of 'order_payment_screen_content.dart';

class OrderPaymentScreenContentLoading extends HookWidget {
  final VoidCallback onNavBackClicked;

  const OrderPaymentScreenContentLoading({
    super.key,
    required this.onNavBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderPaymentScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
