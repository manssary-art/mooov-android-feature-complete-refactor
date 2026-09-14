import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../country_picker_screen.dart';

class CountryPickerScreenPreview extends HookWidget with PreviewMixin {
  @override
  String get name => 'CountryPickerScreen';

  CountryPickerScreenPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) => CountryPickerScreen(
              onValuePicked: (value) {
                Navigator.of(context).pop(value);
              },
            ),
          ),
          child: const Text('Open'),
        ),
      ),
    );
  }
}
