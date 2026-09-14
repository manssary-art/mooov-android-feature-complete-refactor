part of 'order_worker_selection_screen_content.dart';

class OrderWorkerSelectionScreenContentLoading extends HookWidget {
  final VoidCallback onNavBackClicked;

  const OrderWorkerSelectionScreenContentLoading({
    super.key,
    required this.onNavBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderWorkerSelectionScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
