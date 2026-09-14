import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../loading/loading_indicator.dart';
import 'rating_tile.dart';

class UserProfileTile extends StatelessWidget {
  final String? name;
  final double? rating;
  final String? imageUrl;
  final double imageSize;
  final List<String>? tags;

  const UserProfileTile({
    super.key,
    this.name,
    this.rating,
    this.imageUrl,
    this.imageSize = 40,
    this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(imageSize / 8)),
          child: SizedBox(
            height: imageSize,
            width: imageSize,
            child: Builder(
              builder: (context) {
                if (imageUrl == null) {
                  return Assets.images.iconLegoGuy.image();
                }

                return CachedNetworkImage(
                  progressIndicatorBuilder: (context, _, __) => Container(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: const Center(child: LoadingIndicator()),
                  ),
                  errorWidget: (context, _, __) => Assets.images.iconLegoGuy.image(),
                  fit: BoxFit.cover,
                  imageUrl: imageUrl!,
                  height: 144,
                  width: 144,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name != null) ...[
                  Text(name!),
                ],
                if (rating != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(rating!.toStringAsFixed(2)),
                      Container(width: 4),
                      RatingTile(
                        value: rating!,
                        size: 18,
                      ),
                    ],
                  ),
                ],
                if (tags != null) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (final tag in tags!) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            tag,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
