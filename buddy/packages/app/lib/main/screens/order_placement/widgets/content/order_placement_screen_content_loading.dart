part of 'order_placement_screen_content.dart';

class OrderPlacementScreenContentLoading extends StatelessWidget {
  const OrderPlacementScreenContentLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _OrderPlacementScreenScaffold(
      index: 0,
      items: [],
      child: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
