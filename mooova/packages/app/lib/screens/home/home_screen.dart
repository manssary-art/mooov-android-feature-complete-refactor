import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/types/order_type.dart';
import '../../../core/ext/riverpod_ext.dart';
import '../../../core/hooks/flutter_hooks.dart';
import 'providers/_home_providers.dart';
import 'widgets/content/home_screen_content.dart';

class HomeScreen extends HookConsumerWidget {
  final void Function(OrderType) onNavToOrderPlacement;

  const HomeScreen({
    super.key,
    required this.onNavToOrderPlacement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocation = ref.watch(userLocationProvider);
    final banner = ref.watch(bannerProvider);
    final localeNotifier = ref.watch(localeProvider.notifier);

    usePostFrameEffect(() {
      localeNotifier.onValueChanged(context.locale.languageCode);
      return null;
    }, [context.locale]);

    return HomeScreenContent(
      userLocation: userLocation.valueOrNull,
      info: banner.valueOrNull,
      onPlaceOrderClicked: onNavToOrderPlacement,
      onHowItWorksClicked: () {},
      onWhatCanDoClicked: () {},
    );
  }
}
