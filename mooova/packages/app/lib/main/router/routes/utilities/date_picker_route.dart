import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utilities/date_picker/date_picker_screen.dart' deferred as lazy_date_picker_screen;

Future<DateTime?> showDatePickerBottomModalSheet({
  required BuildContext context,
  required DateTime? initial,
}) =>
    showModalBottomSheet<DateTime>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_date_picker_screen.loadLibrary,
          builder: (context) {
            return lazy_date_picker_screen.DatePickerScreen(
              initial: initial,
              onValuePicked: (value) => Navigator.of(context).pop(value),
            );
          },
        ),
      ),
    );
