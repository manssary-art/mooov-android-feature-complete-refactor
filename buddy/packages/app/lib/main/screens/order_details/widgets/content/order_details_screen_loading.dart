part of 'order_details_screen_content.dart';

class OrderDetailsScreenContentLoading extends StatelessWidget {
  final VoidCallback onNavBackClicked;

  const OrderDetailsScreenContentLoading({
    super.key,
    required this.onNavBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderDetailsScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
