import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utilities/country_picker/country_picker_screen.dart'
    deferred as lazy_country_picker_screen;

Future<Country?> showCountryPickerBottomModalSheet({
  required BuildContext context,
  required Country? initial,
}) =>
    showModalBottomSheet<Country>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_country_picker_screen.loadLibrary,
          builder: (context) {
            return lazy_country_picker_screen.CountryPickerScreen(
              onValuePicked: (value) => Navigator.of(context).pop(value),
              initial: initial,
            );
          },
        ),
      ),
    );
