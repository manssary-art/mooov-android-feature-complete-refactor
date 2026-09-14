import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../models/types/user_role_type.dart';
import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../widgets/content/profile_screen_content.dart';

class ProfileScreenPreview extends HookWidget with PreviewMixin {
  ProfileScreenPreview({
    super.key,
  });

  @override
  String get name => 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final tab = useState(UserRole.user);
    return ProfileScreenContentLoaded(
      selectedTab: tab.value,
      onTabClicked: tab.onValueChanged,
      user: useMemoized(() => fakeUserModel()),
      onOpenUserInfoClicked: () {},
      onUpdateVehicleImageClicked: () {},
      onSignOutClicked: () {},
      onShareClicked: () {},
      onImageShareClicked: () {},
      onOpenSavedCardClicked: () {},
      onOpenNotificationSettingsClicked: () {},
      onOpenWorkerApplicationFormClicked: () {},
      onOpenBusinessInfoClicked: () {},
    );
  }
}
