import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends HookWidget {
  final ValueSetter<XFile?> onValuePicked;

  const ImagePickerScreen({
    super.key,
    required this.onValuePicked,
  });

  @override
  Widget build(BuildContext context) {
    final pickImage = useCallback((ImageSource source) async {
      onValuePicked(await ImagePicker().pickImage(source: source));
    }, [onValuePicked]);

    return _ImagePickerScreenContent(
      onGalleryClicked: () => pickImage(ImageSource.gallery),
      onCameraClicked: () => pickImage(ImageSource.camera),
    );
  }
}

class _ImagePickerScreenContent extends HookWidget {
  final void Function() onGalleryClicked;
  final void Function() onCameraClicked;

  const _ImagePickerScreenContent({
    super.key,
    required this.onGalleryClicked,
    required this.onCameraClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Clickable(
            onTap: onGalleryClicked,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              child: Assets.images.iconGalleryOutlined.image(
                width: 40,
                height: 40,
              ),
            ),
          ),
          Clickable(
            onTap: onCameraClicked,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              child: Assets.images.iconCameraOutlined.image(
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
