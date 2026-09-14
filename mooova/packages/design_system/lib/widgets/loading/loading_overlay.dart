import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class LoadingOverlayController extends ValueNotifier<bool> {
  LoadingOverlayController(super.value);
}

class LoadingOverlay extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final Color? background;
  final double? opacity;

  const LoadingOverlay({
    super.key,
    required this.isVisible,
    required this.child,
    this.background,
    this.opacity,
  });

  static Widget controller({
    required LoadingOverlayController controller,
    required Widget child,
    final Color? background,
    final double? opacity,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (context, value, _) {
        return LoadingOverlay(
          isVisible: value,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final background = this.background ?? Theme.of(context).colorScheme.primaryContainer;
    final opacity = this.opacity ?? 0.8;
    return Stack(
      children: [
        child,
        if (isVisible) ...[
          Container(
            color: background.withOpacity(opacity),
            child: const Center(
              child: LoadingIndicator(),
            ),
          ),
        ],
      ],
    );
  }
}
