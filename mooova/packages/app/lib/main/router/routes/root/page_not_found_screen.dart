import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  final VoidCallback onNavToRoot;

  const PageNotFoundScreen({
    super.key,
    required this.onNavToRoot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Page not found"),
            FilledButton(
              onPressed: onNavToRoot,
              child: const Text("Go home"),
            ),
          ],
        ),
      ),
    );
  }
}
