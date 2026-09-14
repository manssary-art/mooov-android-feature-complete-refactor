import 'package:flutter/material.dart';
import 'package:generated_assets/assets.gen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeImageCard extends StatelessWidget {
  final AssetGenImage image;
  final String text;
  final VoidCallback? onClicked;
  final Color? backgroundColor;
  final Color? textColor;
  final bool wide;

  const HomeImageCard({
    super.key,
    required this.image,
    required this.text,
    this.onClicked,
    this.backgroundColor,
    this.textColor,
    this.wide = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onClicked,
        child: Stack(
          children: [
            Container(
              color: backgroundColor,
              child: image.image(
                fit: BoxFit.cover,
              ),
            ),
            Builder(builder: (context) {
              final isTablet = ResponsiveBreakpoints.of(context).breakpoint.end > 450;
              final increment = isTablet ? 24.0 : 0.0;
              return Positioned.fill(
                left: 18 + increment,
                top: (wide ? 20 : 16) + increment,
                right: (wide ? 180 : 0) + increment,
                bottom: 18 + increment,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
