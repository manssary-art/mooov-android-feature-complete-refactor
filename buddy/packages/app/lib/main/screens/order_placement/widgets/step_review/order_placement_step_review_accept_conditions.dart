part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentAcceptConditions extends StatelessWidget {
  final bool isAccepted;
  final void Function(bool value) onAcceptTermClicked;

  const _OrderPlacementStepReviewContentAcceptConditions({
    super.key,
    required this.isAccepted,
    required this.onAcceptTermClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () => onAcceptTermClicked(!isAccepted),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isAccepted ? Assets.images.iconCheckboxChecked : Assets.images.iconCheckboxUnchecked).image(
              width: 24,
              height: 24,
            ),
            Container(width: 8),
            Expanded(
              child: Text(
                LocaleKeys.CheckBoxDes.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
