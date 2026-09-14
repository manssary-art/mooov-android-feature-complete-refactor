import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../../core/hooks/flutter_hooks.dart';
import '../widgets/modal/profile_update_business_info_modal_content.dart';

class ProfileScreenUpdateBusinessInfoDialogPreview extends HookWidget with PreviewMixin {
  ProfileScreenUpdateBusinessInfoDialogPreview({
    super.key,
  });

  @override
  String get name => 'ProfileScreen_BusinessInfoDialog';

  @override
  Widget build(BuildContext context) {
    final isWorking = usePreviewSwitch('isWorking', false);
    final isWorkingNotifier = useValueNotifier(isWorking);

    usePostFrameEffect(() {
      isWorkingNotifier.value = isWorking;
      return null;
    }, [isWorkingNotifier, isWorking]);

    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => HookBuilder(
              builder: (context) {
                final isWorking = useValueListenable(isWorkingNotifier);
                return ProfileUpdateBusinessInfoModalContent(
                  user: fakeUserModel(),
                  isWorking: isWorking,
                  onNavBackClicked: () => Navigator.of(context).pop(),
                  onSubmitClicked: (value) {},
                );
              },
            ),
          ),
          child: const Text('Open'),
        ),
      ),
    );
  }
}
