part of 'worker_application_form_screen_content.dart';

class WorkerApplicationFormScreenContentError extends HookWidget {
  final Object? error;
  final VoidCallback onNavBackClicked;
  final VoidCallback onTryAgainClicked;

  const WorkerApplicationFormScreenContentError({
    super.key,
    required this.error,
    required this.onNavBackClicked,
    required this.onTryAgainClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _WorkerApplicationFormScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: UnableToLoadContent(
        error: error,
        onTryAgainClicked: onTryAgainClicked,
      ),
    );
  }
}
