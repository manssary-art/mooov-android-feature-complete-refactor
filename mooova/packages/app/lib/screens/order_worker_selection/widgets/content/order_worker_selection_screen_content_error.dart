part of 'order_worker_selection_screen_content.dart';

class OrderWorkerSelectionScreenContentError extends HookWidget {
  final Object? error;
  final VoidCallback onNavBackClicked;
  final VoidCallback onTryAgainClicked;

  const OrderWorkerSelectionScreenContentError({
    super.key,
    required this.error,
    required this.onNavBackClicked,
    required this.onTryAgainClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderWorkerSelectionScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: UnableToLoadContent(
        error: error,
        onTryAgainClicked: onTryAgainClicked,
      ),
    );
  }
}
