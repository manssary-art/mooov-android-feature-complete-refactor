import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SetupMaterialAppChild extends StatelessWidget {
  final WidgetBuilder builder;

  const SetupMaterialAppChild({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: Builder(
        builder: (context) {
          return MaxWidthBox(
            maxWidth: 800,
            background: Container(color: ColorName.neutral10),
            child: ResponsiveScaledBox(
              width: ResponsiveValue<double>(
                context,
                conditionalValues: [
                  const Condition.equals(name: MOBILE, value: 450),
                  const Condition.between(start: 800, end: 1100, value: 800),
                  const Condition.between(start: 1000, end: 1200, value: 1000),

                  /// There are no conditions for width over 1200
                  /// because the `maxWidth` is set to 1200 via the MaxWidthBox.
                ],
              ).value,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(boldText: false),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    body: Builder(
                      builder: builder,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
