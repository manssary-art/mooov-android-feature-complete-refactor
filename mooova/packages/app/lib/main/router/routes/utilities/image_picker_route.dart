import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utilities/image_picker/image_picker_screen.dart' deferred as lazy_image_picker_screen;

Future<XFile?> showImagePickerBottomModalSheet({
  required BuildContext context,
}) =>
    showModalBottomSheet<XFile>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_image_picker_screen.loadLibrary,
          builder: (context) {
            return lazy_image_picker_screen.ImagePickerScreen(
              onValuePicked: (value) => Navigator.of(context).pop(value),
            );
          },
        ),
      ),
    );
