part of 'worker_application_form_screen_content.dart';

class WorkerApplicationFormScreenContentLoading extends HookWidget {
  final VoidCallback onNavBackClicked;

  const WorkerApplicationFormScreenContentLoading({
    super.key,
    required this.onNavBackClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _WorkerApplicationFormScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
