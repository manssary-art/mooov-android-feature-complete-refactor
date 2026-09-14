part of 'order_payment_screen_content.dart';

class OrderPaymentScreenContentError extends HookWidget {
  final Object? error;
  final VoidCallback onNavBackClicked;
  final VoidCallback onTryAgainClicked;

  const OrderPaymentScreenContentError({
    super.key,
    required this.error,
    required this.onNavBackClicked,
    required this.onTryAgainClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderPaymentScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: UnableToLoadContent(
        error: error,
        onTryAgainClicked: onTryAgainClicked,
      ),
    );
  }
}
