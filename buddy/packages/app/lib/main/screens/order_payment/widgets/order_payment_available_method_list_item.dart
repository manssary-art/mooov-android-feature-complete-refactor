import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/assets.gen.dart';

class OrderPaymentAvailableMethodListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final AssetGenImage image;

  const OrderPaymentAvailableMethodListItem({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Clickable(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: image.image(
                        height: 32,
                      ),
                    ),
                  ],
                ),
                Container(width: 16),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
