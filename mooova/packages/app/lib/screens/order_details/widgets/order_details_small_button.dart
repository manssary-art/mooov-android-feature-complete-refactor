import 'package:flutter/material.dart';

class OrderDetailsSmallButton extends StatelessWidget {
  final String text;
  final IconData? icon;

  const OrderDetailsSmallButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon),
            Container(width: 2),
          ],
          Text(text),
        ],
      ),
    );
  }
}
