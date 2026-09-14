import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      size: 24,
      color: color ?? Theme.of(context).primaryColor,
    );
  }
}
