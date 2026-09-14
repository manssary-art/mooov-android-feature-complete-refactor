import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/explore_ads_model.dart';

class ExploreAdListItem extends StatelessWidget {
  final ExploreAdModel ad;

  const ExploreAdListItem({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: CachedNetworkImage(
        imageUrl: ad.imageUrl,
      ),
    );
  }
}
