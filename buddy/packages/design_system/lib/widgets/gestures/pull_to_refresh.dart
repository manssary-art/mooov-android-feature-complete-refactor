import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../design_system.dart';

const _indicatorSize = 80.0;

class PullToRefresh extends HookWidget {
  final AsyncCallback onRefresh;
  final Widget child;

  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final renderCompleteState = useState(false);
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: onRefresh,
      completeStateDuration: const Duration(seconds: 1),
      onStateChanged: (change) {
        /// set [_renderCompleteState] to true when controller.state become completed
        if (change.didChange(to: IndicatorState.complete)) {
          renderCompleteState.value = true;

          /// set [_renderCompleteState] to false when controller.state become idle
        } else if (change.didChange(to: IndicatorState.idle)) {
          renderCompleteState.value = false;
        }
      },
      builder: (BuildContext context, Widget child, IndicatorController controller) {
        return _PullToRefreshIndicator(
          controller: controller,
          renderCompleteState: renderCompleteState.value,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _PullToRefreshIndicator extends HookWidget {
  final bool renderCompleteState;
  final IndicatorController controller;
  final Widget child;

  const _PullToRefreshIndicator({
    required this.renderCompleteState,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final prevScrollDirection = useValueNotifier(ScrollDirection.idle);
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            if ((controller.isDragging || controller.isArmed) &&
                controller.scrollingDirection == ScrollDirection.reverse &&
                prevScrollDirection.value == ScrollDirection.forward) {
              controller.stopDrag();
            }

            prevScrollDirection.value = controller.scrollingDirection;
            final containerHeight = controller.value * _indicatorSize;
            if (controller.isIdle) {
              return Container();
            }

            return Container(
              alignment: Alignment.center,
              height: containerHeight,
              child: OverflowBox(
                maxHeight: 40,
                minHeight: 40,
                maxWidth: 40,
                minWidth: 40,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: LoadingIndicator(),
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          builder: (context, _) {
            return Transform.translate(
              offset: Offset(0.0, controller.value * _indicatorSize),
              child: child,
            );
          },
          animation: controller,
        ),
      ],
    );
  }
}
