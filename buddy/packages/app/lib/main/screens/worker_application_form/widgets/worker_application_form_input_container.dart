import 'package:flutter/material.dart';
import 'package:generated_assets/colors.gen.dart';

enum ApplicationFormFieldBuilderStyle {
  leftText,
  divider,
}

class WorkerApplicationFormInputContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final bool isValid;
  final ApplicationFormFieldBuilderStyle style;
  final EdgeInsetsGeometry padding;

  const WorkerApplicationFormInputContainer({
    super.key,
    required this.title,
    required this.child,
    this.style = ApplicationFormFieldBuilderStyle.divider,
    this.padding = EdgeInsets.zero,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              children: [
                if (style == ApplicationFormFieldBuilderStyle.leftText) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isValid ? Theme.of(context).textTheme.bodyLarge?.color : ColorName.error,
                          ),
                    ),
                  ),
                ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: child,
                  ),
                ),
              ],
            ),
            if (style == ApplicationFormFieldBuilderStyle.divider) ...[
              Container(
                height: 1,
                color: isValid ? Theme.of(context).disabledColor : ColorName.error,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
