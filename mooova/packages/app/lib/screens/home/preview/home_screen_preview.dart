import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../widgets/content/home_screen_content.dart';

class HomeScreenPreview extends HookWidget with PreviewMixin {
  HomeScreenPreview({
    super.key,
  });

  @override
  String get name => 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return HomeScreenContent(
      userLocation: "Stockholm",
      info:
          "Mooova was created to help you transport. 24*7. Get everything delivered while you enjoy your moments on the couch.  Get help first and pay later. 🚀👍",
      onPlaceOrderClicked: (value) {},
      onHowItWorksClicked: () {},
      onWhatCanDoClicked: () {},
    );
  }
}
