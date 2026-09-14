import 'package:flutter/material.dart';
import 'package:generated_assets/assets.gen.dart';

class ActivitiesItemContentProgress extends StatelessWidget {
  final String? title;
  final AssetGenImage image;
  final double imageSize;
  final Alignment imageAlignment;
  final double progress;

  const ActivitiesItemContentProgress({
    super.key,
    required this.title,
    required this.image,
    required this.imageSize,
    required this.imageAlignment,
    required this.progress,
  });

  factory ActivitiesItemContentProgress.worker({
    String? title,
    required double progress,
  }) =>
      ActivitiesItemContentProgress(
        title: title,
        progress: progress,
        image: Assets.images.iconMoverBlack,
        imageSize: 24.0,
        imageAlignment: Alignment.bottomRight,
      );

  factory ActivitiesItemContentProgress.owner({
    String? title,
    required double progress,
  }) =>
      ActivitiesItemContentProgress(
        title: title,
        progress: progress,
        image: Assets.images.iconRocket,
        imageSize: 16.0,
        imageAlignment: Alignment.centerRight,
      );

  @override
  Widget build(BuildContext context) {
    const progressHeight = 16.0;
    const progressRadius = 8.0;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).disabledColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: progressHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(progressRadius)),
                    ),
                  ),
                  Align(
                    alignment: imageAlignment,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: image.image(
                        height: imageSize,
                        width: imageSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (title != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
