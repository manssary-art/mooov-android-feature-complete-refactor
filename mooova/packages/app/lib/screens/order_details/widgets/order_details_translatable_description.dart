import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linkable/linkable.dart';

class OrderDetailsTranslatableDescription extends HookWidget {
  final String title;
  final String content;
  final VoidCallback onTranslateClicked;

  const OrderDetailsTranslatableDescription({
    super.key,
    required this.content,
    required this.title,
    required this.onTranslateClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Clickable(
              onTap: onTranslateClicked,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.g_translate,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        Container(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          constraints: const BoxConstraints(minHeight: 120),
          width: double.infinity,
          child: Linkable(
            text: content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
