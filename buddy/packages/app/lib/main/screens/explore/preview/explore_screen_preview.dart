import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../../../../models/explore_ads_model.dart';
import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/order_type.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../models/explore_tab.dart';
import '../widgets/content/explore_screen_content.dart';

class ExploreScreenPreview extends HookWidget with PreviewMixin {
  ExploreScreenPreview({
    super.key,
  });

  @override
  String get name => 'ExploreScreen';

  @override
  Widget build(BuildContext context) {
    final orderCategories = OrderType.values.associateBy((e) => e.name);
    final orderType = usePreviewOptions('OrderType', orderCategories.keys.toList());
    final enableAds = usePreviewSwitch('EnableAds');
    final order = fakeOrderModel();
    final orders = OrderState.values
        .map((s) => order.copyWith(
              orderType: orderCategories[orderType]!.copy,
              orderState: s.copy,
              description: 's=${s.name} ${order.description}'.copy,
            ))
        .toList();
    final ads = ExploreAdsModel(
      gap: 3,
      content: [
        ExploreAdModel(id: '0', imageUrl: fakeImageUrl, action: null, locale: null),
      ],
    );

    final tab = useState(ExploreTab.all);
    return ExploreScreenContentLoaded(
      items: orders,
      ads: ads.takeIf((it) => enableAds),
      isRefreshing: false,
      selectedTab: tab.value,
      onTabClicked: tab.onValueChanged,
      onItemClicked: (value) {},
      onPullToRefresh: () {},
      onAdClicked: (value) {},
    );
  }
}
