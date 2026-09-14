import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/colors.gen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SetupGlobalLoaderOverlay extends StatelessWidget {
  final WidgetBuilder builder;

  const SetupGlobalLoaderOverlay({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: LoadingIndicator(),
      ),
      overlayColor: ColorName.primary100,
      overlayOpacity: 0.3,
      child: Builder(builder: builder),
    );
  }
}
