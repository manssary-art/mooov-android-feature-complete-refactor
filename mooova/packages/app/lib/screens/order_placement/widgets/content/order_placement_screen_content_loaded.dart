part of 'order_placement_screen_content.dart';

class OrderPlacementScreenContentLoaded extends StatelessWidget {
  final bool isWorking;
  final void Function() onNavBackClicked;
  final List<OrderPlacementStep> steps;
  final OrderPlacementStep step;
  final Widget Function(BuildContext context, OrderPlacementStep step) builder;

  const OrderPlacementScreenContentLoaded({
    super.key,
    required this.isWorking,
    required this.onNavBackClicked,
    required this.steps,
    required this.step,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onNavBackClicked();
        return false;
      },
      child: LoadingOverlay(
        isVisible: isWorking,
        child: _OrderPlacementScreenScaffold(
          index: steps.indexOf(step),
          items: [
            LocaleKeys.Step1.tr(),
            LocaleKeys.Step2.tr(),
            LocaleKeys.Step3.tr(),
          ],
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTowardsTransition(
                type: FadeTowardsTransitionType.rightToLeft,
                animation: animation,
                child: child,
              );
            },
            child: SizedBox(
              key: ValueKey(step),
              child: builder(context, step),
            ),
          ),
        ),
      ),
    );
  }
}
