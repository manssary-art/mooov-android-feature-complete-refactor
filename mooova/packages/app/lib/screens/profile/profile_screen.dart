import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/_profile_providers.dart';
import 'widgets/content/profile_screen_content.dart';
import 'widgets/modal/profile_update_business_info_modal_content.dart';
import 'widgets/modal/profile_update_user_info_modal_content.dart';

class ProfileScreen extends HookConsumerWidget {
  final VoidCallback onNavToHome;
  final VoidCallback onNavToWorkerApplicationForm;
  final VoidCallback onNavToSavedCards;
  final VoidCallback onNavToNotificationSettings;
  final AsyncValueGetter<XFile?> onNavToImagePicker;

  const ProfileScreen({
    super.key,
    required this.onNavToHome,
    required this.onNavToWorkerApplicationForm,
    required this.onNavToSavedCards,
    required this.onNavToNotificationSettings,
    required this.onNavToImagePicker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(profileProvider);
    final initialNotifier = ref.watch(profileProvider.notifier);
    final sideEffect = ref.watch(sideEffectProvider);
    final selectedTab = ref.watch(selectedTabProvider);
    final selectedTabNotifier = ref.watch(selectedTabProvider.notifier);
    final businessInfoNotifier = ref.watch(businessInfoProvider.notifier);
    final userInfoNotifier = ref.watch(userInfoProvider.notifier);
    final workerInfoNotifier = ref.watch(workerInfoProvider.notifier);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case ProfileSideEffect$NavToHome():
            onNavToHome();
            break;
          case ProfileSideEffect$NavToWorkerApplicationForm():
            onNavToWorkerApplicationForm();
            break;
          case ProfileSideEffect$NavToVehicleImagePicker():
            final file = await onNavToImagePicker();
            if (file != null) {
              workerInfoNotifier.onVehicleImagePicked(file);
            }
            break;
          case ProfileSideEffect$NavToProfileImagePicker():
            break;
          case ProfileSideEffect$NavToUpdateBusinessInfo():
            showDialog(
              context: context,
              builder: (context) {
                return HookConsumer(
                  builder: (context, ref, child) {
                    final userInfo = ref.watch(businessInfoProvider);
                    final isWorking = ref.watch(isWorkingProvider);
                    return WillPopScope(
                      onWillPop: () async => !isWorking,
                      child: ProfileUpdateBusinessInfoModalContent(
                        user: userInfo!,
                        isWorking: isWorking,
                        onNavBackClicked: () => Navigator.of(context).pop(),
                        onSubmitClicked: (value) {
                          businessInfoNotifier.onSubmitBusinessInfoClicked(value);
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            );
            break;
          case ProfileSideEffect$NavToUpdateUserInfo():
            showDialog(
              context: context,
              builder: (context) {
                return HookConsumer(
                  builder: (context, ref, child) {
                    final userInfo = ref.watch(userInfoProvider);
                    final pickedImage = useState<XFile?>(null);
                    final isWorking = ref.watch(isWorkingProvider);
                    return WillPopScope(
                      onWillPop: () async => !isWorking,
                      child: ProfileUpdateUserInfoModalContent(
                        user: userInfo!,
                        isWorking: isWorking,
                        pickedImage: pickedImage.value,
                        onNavBackClicked: () => Navigator.of(context).pop(),
                        onPickImageClicked: () async {
                          final file = await onNavToImagePicker();
                          if (file != null) {
                            pickedImage.value = file;
                          }
                        },
                        onSubmitClicked: (value) {
                          userInfoNotifier.onSubmitUserInfoClicked(value);
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            );
            break;
          case ProfileSideEffect$NavToSavedCards():
            onNavToSavedCards();
            break;
          case ProfileSideEffect$NavToNotificationSettings():
            onNavToNotificationSettings();
            break;
        }
      }).cancel,
      [sideEffect],
    );

    if (initial.isLoading && !initial.hasValue) {
      return ProfileScreenContentLoading(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onTabChanged,
      );
    }

    if (initial.hasError) {
      return ProfileScreenContentError(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onTabChanged,
      );
    }

    final isWorking = ref.watch(isWorkingProvider);
    return LoadingOverlay(
      isVisible: isWorking,
      child: ProfileScreenContentLoaded(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onTabChanged,
        user: initial.requireValue,
        onUpdateVehicleImageClicked: workerInfoNotifier.onUpdateVehicleImageClicked,
        onSignOutClicked: initialNotifier.onLogoutClicked,
        onShareClicked: initialNotifier.onShareClicked,
        onImageShareClicked: initialNotifier.onImageShareClicked,
        onOpenUserInfoClicked: userInfoNotifier.onOpenUserInfoClicked,
        onOpenSavedCardClicked: initialNotifier.onOpenSavedCardClicked,
        onOpenNotificationSettingsClicked: initialNotifier.onOpenNotificationSettingsClicked,
        onOpenWorkerApplicationFormClicked: workerInfoNotifier.onOpenWorkerApplicationFormClicked,
        onOpenBusinessInfoClicked: businessInfoNotifier.onOpenBusinessInfoClicked,
      ),
    );
  }
}
