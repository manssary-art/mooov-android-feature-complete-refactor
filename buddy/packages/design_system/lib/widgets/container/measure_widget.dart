import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChanged = void Function(Size size);

class MeasureWidget extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChanged? onSizeChanged;

  const MeasureWidget({
    super.key,
    this.onSizeChanged,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onSizeChanged);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _MeasureSizeRenderObject renderObject) {
    renderObject.onSizeChanged = onSizeChanged;
  }
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChanged? onSizeChanged;

  _MeasureSizeRenderObject(this.onSizeChanged);

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSizeChanged?.call(newSize);
    });
  }
}
