import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:preview/preview.dart';

import 'screens/activities/preview/activities_screen_preview.dart';
import 'screens/authentication/preview/authentication_screen_preview.dart';
import 'screens/explore/preview/explore_screen_preview.dart';
import 'screens/home/preview/home_screen_preview.dart';
import 'screens/order_details/preview/order_details_screen_preview.dart';
import 'screens/order_payment/preview/order_payment_screen_preview.dart';
import 'screens/order_placement/preview/order_placement_screen_preview.dart';
import 'screens/order_worker_selection/preview/order_worker_selection_screen_preview.dart';
import 'screens/profile/preview/profile_screen_preview.dart';
import 'screens/profile/preview/profile_update_business_info_dialog_preview.dart';
import 'screens/profile/preview/profile_update_user_info_dialog_preview.dart';
import 'screens/utilities/country_picker/preview/country_picker_screen_preview.dart';
import 'screens/utilities/date_picker/preview/date_picker_screen_preview.dart';
import 'screens/worker_application_form/preview/worker_application_form_screen_preview.dart';
import 'preview/preview_setup_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PreviewApp.ensureInitialized();
  final cacheManager = DefaultCacheManager();
  await cacheManager.store.emptyCache();

  final screens = <PreviewMixin>[
    ExploreScreenPreview(),
    ActivitiesScreenPreview(),
    OrderDetailsScreenPreview(),
    OrderPlacementScreenPreview(),
    AuthenticationScreenPreview(),
    HomeScreenPreview(),
    ProfileScreenPreview(),
    ProfileScreenUpdateBusinessInfoDialogPreview(),
    ProfileScreenUpdateUserInfoDialogPreview(),
    DatePickerScreenPreview(),
    WorkerApplicationFormScreenPreview(),
    CountryPickerScreenPreview(),
    OrderWorkerSelectionScreenPreview(),
    OrderPaymentScreenPreview(),
  ];

  runApp(
    PreviewSetupApp(
      screens: screens,
    ),
  );
}
