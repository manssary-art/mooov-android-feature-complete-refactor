import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class SimpleAssetImageTextTile extends StatelessWidget {
  final AssetGenImage image;
  final String text;
  final TextStyle? textStyle;

  const SimpleAssetImageTextTile({
    Key? key,
    required this.image,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image.image(
          width: 16,
          height: 16,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        )
      ],
    );
  }
}
