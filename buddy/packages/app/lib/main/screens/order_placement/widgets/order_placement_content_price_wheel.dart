import 'dart:math';

import 'package:core/core.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderPlacementContentPriceWheel extends StatefulWidget {
  final double size;
  final Money min;
  final Money max;
  final Money? initial;
  final double degreePerUnit;
  final Function(Money price) onPriceChanged;
  final Currency currency;

  const OrderPlacementContentPriceWheel({
    Key? key,
    this.size = 256,
    required this.min,
    required this.max,
    this.initial,
    this.degreePerUnit = 3,
    required this.onPriceChanged,
    required this.currency,
  }) : super(key: key);

  @override
  _PriceWheelPickerState createState() => _PriceWheelPickerState();
}

class _PriceWheelPickerState extends State<OrderPlacementContentPriceWheel> {
  double finalAngle = 0.0;
  double lastStopAngle = 0.0;
  double upsetAngle = 0.0;
  double oldFinalAngle = 0.0;
  late Money price;

  @override
  void initState() {
    super.initState();
    price = widget.initial ?? widget.min;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onPriceChanged(price);
    });
  }

  @override
  void didUpdateWidget(covariant OrderPlacementContentPriceWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial != null && oldWidget.initial != widget.initial) {
      setState(() {
        price = widget.initial!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      margin: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (details) => _onPanStart(constraints, details.localPosition),
            onPanUpdate: (details) => _onPanUpdate(constraints, details.localPosition),
            onPanEnd: (details) => _onPanEnd(),
            onVerticalDragStart: (details) => _onPanStart(constraints, details.localPosition),
            onVerticalDragUpdate: (details) => _onPanUpdate(constraints, details.localPosition),
            onVerticalDragEnd: (details) => _onPanEnd(),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(42),
                      child: Assets.images.imagePlaceOrderPricingWheelInside.image(),
                    ),
                    Transform.rotate(
                      angle: finalAngle,
                      child: Assets.images.imagePlaceOrderPricingWheel.image(),
                    ),
                    const Positioned(
                      top: 0,
                      right: 8,
                      child: Icon(Icons.add),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 8,
                      child: Icon(Icons.remove),
                    )
                  ],
                ),
                Center(
                  child: Builder(
                    builder: (context) {
                      final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          );

                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "${price.toInt()}",
                              style: style?.copyWith(fontSize: 32),
                            ),
                            TextSpan(
                              text: "\n${widget.currency.symbol()}",
                              style: style?.copyWith(fontSize: 18, height: 0.5),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onPanStart(BoxConstraints constraints, Offset position) {
    final centerOfGestureDetector = Offset(
      constraints.maxWidth / 2,
      constraints.maxHeight / 2,
    );

    final touchPositionFromCenter = position - centerOfGestureDetector;
    upsetAngle = lastStopAngle - touchPositionFromCenter.direction;
  }

  void _onPanEnd() {
    setState(() {
      lastStopAngle = finalAngle;
    });

    widget.onPriceChanged(price);
  }

  void _onPanUpdate(BoxConstraints constraints, Offset position) {
    final centerOfGestureDetector = Offset(
      constraints.maxWidth / 2,
      constraints.maxHeight / 2,
    );
    final touchPositionFromCenter = position - centerOfGestureDetector;

    setState(() {
      finalAngle = touchPositionFromCenter.direction + upsetAngle;
      onPriceChanged();
    });
  }

  void onPriceChanged() {
    final finalAngleDegrees = degrees(finalAngle);
    final oldAngleDegrees = degrees(oldFinalAngle);
    final diff = finalAngleDegrees - oldAngleDegrees;

    if (diff.abs() < widget.degreePerUnit) {
      return;
    }

    Money newPrice;
    oldFinalAngle = finalAngle;
    if (diff > 0) {
      newPrice = price + 1;
    } else {
      newPrice = price - 1;
    }

    if (newPrice >= widget.max) {
      price = widget.max;
    } else if (newPrice >= widget.min) {
      price = newPrice;
    } else {
      price = widget.min;
    }
  }
}

const double radians2Degrees = 180.0 / pi;

double degrees(double radians) => radians * radians2Degrees;
