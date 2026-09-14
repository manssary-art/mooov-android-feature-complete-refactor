import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../di/di.dart';
import '../../../screens/utilities/location_permission_request/location_permission_request_screen.dart'
    deferred as lazy_location_permission_request_screen;

Future<void> showLocationPermissionRequestBottomModalSheet({
  required BuildContext context,
}) =>
    showModalBottomSheet<void>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_location_permission_request_screen.loadLibrary,
          builder: (context) {
            return lazy_location_permission_request_screen
                .LocationPermissionRequestScreen(
              onNavBack: () => Navigator.of(context).pop(),
              requestPermission: () => Di.locationService.getLocationPermission(
                requestPermission: true,
              ),
            );
          },
        ),
      ),
    );
