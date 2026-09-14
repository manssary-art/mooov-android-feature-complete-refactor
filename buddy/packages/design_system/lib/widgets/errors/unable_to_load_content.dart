import 'package:flutter/material.dart';
import 'package:generated_assets/colors.gen.dart';

class UnableToLoadContent extends StatelessWidget {
  final Object? error;
  final VoidCallback? onTryAgainClicked;

  const UnableToLoadContent({
    super.key,
    this.onTryAgainClicked,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: ColorName.error,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              "Unable to load content",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (error != null) ...[
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
            const SizedBox(height: 16),
            if (onTryAgainClicked != null) ...[
              FilledButton(
                onPressed: onTryAgainClicked,
                child: const Text("Try again"),
              )
            ]
          ],
        ),
      ),
    );
  }
}
