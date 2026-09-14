import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../di/di.dart';
import '../../../../models/places_details_model.dart';
import '../../../../screens/utilities/address_picker/address_picker_screen.dart'
    deferred as lazy_address_picker_screen;

Future<PlacesDetailsModel?> showAddressPickerBottomModalSheet({
  required BuildContext context,
}) =>
    showModalBottomSheet<PlacesDetailsModel>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_address_picker_screen.loadLibrary,
          builder: (context) {
            return lazy_address_picker_screen.AddressPickerScreen(
              onValuePicked: (value) => Navigator.of(context).pop(value),
              getPlacesAutoComplete: Di.placesRepository.getPlacesAutoComplete,
              getPlacesDetailsByPlaceId:
                  Di.placesRepository.getPlacesDetailsByPlaceId,
            );
          },
        ),
      ),
    );
