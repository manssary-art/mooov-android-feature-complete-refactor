import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utilities/images_viewer/images_viewer_screen.dart'
    deferred as lazy_images_viewer_screen;
import '../../ext/go_router_ext.dart';

Future<void> showImageViewerBottomModalSheet({
  required BuildContext context,
  required List<String> images,
  int? initialIndex,
}) =>
    showModalBottomSheet<void>(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DeferredBuilder(
          loadLibrary: lazy_images_viewer_screen.loadLibrary,
          builder: (context) {
            return lazy_images_viewer_screen.ImagesViewerScreen(
              images: images,
              initialIndex: initialIndex,
              onNavBack: () => context.popOrGo(),
            );
          },
        ),
      ),
    );
