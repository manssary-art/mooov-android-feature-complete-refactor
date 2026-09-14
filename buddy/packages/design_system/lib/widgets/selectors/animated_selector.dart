import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../design_system.dart';

enum AnimatedSelectorItemSize {
  max,
  min,
  equals,
}

class AnimatedSelector extends HookWidget {
  final int selectedIndex;
  final List<Widget> children;
  final BoxDecoration? indicatorDecoration;
  final Axis axis;
  final AnimatedSelectorItemSize itemSize;
  final CrossAxisAlignment crossAxisAlignment;
  final Duration duration;

  const AnimatedSelector({
    super.key,
    required this.selectedIndex,
    required this.children,
    this.indicatorDecoration,
    this.axis = Axis.horizontal,
    this.itemSize = AnimatedSelectorItemSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final rendered = useState(false);
    final sizes = useState(<int, Size>{});
    final positioned = axis.positioned(selectedIndex, sizes.value, itemSize == AnimatedSelectorItemSize.equals);
    final children = this
        .children
        .mapIndexed(
          (i, child) => Builder(
            builder: (context) {
              switch (itemSize) {
                case AnimatedSelectorItemSize.min:
                  return MeasureWidget(
                    onSizeChanged: (size) => sizes.value = sizes.value.plus(i, size),
                    child: child,
                  );
                case AnimatedSelectorItemSize.equals:
                  return SizedBox(
                    width: positioned.width != 0.0 ? positioned.width : null,
                    height: positioned.height != 0.0 ? positioned.height : null,
                    child: MeasureWidget(
                      onSizeChanged: (size) => sizes.value = sizes.value.plus(i, size),
                      child: child,
                    ),
                  );
                case AnimatedSelectorItemSize.max:
                  return Expanded(
                    child: MeasureWidget(
                      onSizeChanged: (size) => sizes.value = sizes.value.plus(i, size),
                      child: child,
                    ),
                  );
              }
            },
          ),
        )
        .toList();

    return Stack(
      children: [
        AnimatedPositioned(
          curve: Curves.easeInOut,
          top: positioned.top,
          left: positioned.left,
          bottom: positioned.bottom,
          right: positioned.right,
          width: positioned.width,
          height: positioned.height,
          duration: duration,
          onEnd: () => rendered.value = true,
          child: AnimatedOpacity(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 100),
            opacity: rendered.value ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: indicatorDecoration ??
                  BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
            ),
          ),
        ),
        if (axis == Axis.horizontal) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ] else ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ]
      ],
    );
  }
}

extension on Axis {
  double size(Size size) {
    switch (this) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  Positioned positioned(
    int index,
    Map<int, Size> sizes,
    bool useBiggest,
  ) {
    final offset = sizes.entries.take(index).fold<double>(0.0, (acc, e) => acc + this.size(e.value));
    final size = sizes[index] ?? Size.zero;
    final maxWidth = sizes.entries.map((e) => e.value.width).fold<double>(0.0, (acc, e) => e > acc ? e : acc);
    final maxHeight = sizes.entries.map((e) => e.value.height).fold<double>(0.0, (acc, e) => e > acc ? e : acc);
    switch (this) {
      case Axis.horizontal:
        return Positioned(
          top: 0,
          left: offset,
          width: useBiggest ? maxWidth : size.width,
          height: useBiggest ? maxHeight : size.height,
          child: const SizedBox(),
        );
      case Axis.vertical:
        return Positioned(
          left: 0,
          top: offset,
          width: useBiggest ? maxWidth : size.width,
          height: useBiggest ? maxHeight : size.height,
          child: const SizedBox(),
        );
    }
  }
}
