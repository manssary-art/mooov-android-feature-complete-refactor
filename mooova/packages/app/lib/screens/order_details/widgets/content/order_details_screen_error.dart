part of 'order_details_screen_content.dart';

class OrderDetailsScreenContentError extends StatelessWidget {
  final VoidCallback onNavBackClicked;

  const OrderDetailsScreenContentError({
    super.key,
    required this.onNavBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderDetailsScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: UnableToLoadContent(

      )
    );
  }
}
