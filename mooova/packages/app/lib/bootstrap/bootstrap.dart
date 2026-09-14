import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_api/apis/order_activities_api.dart';
import 'package:network_api/apis/order_api.dart';
import 'package:network_api/apis/order_discover_api.dart';
import 'package:network_api/apis/order_management_api.dart';
import 'package:network_api/apis/order_price_recommendation_api.dart';
import 'package:network_api/apis/payment_card_api.dart';
import 'package:network_api/apis/payment_intent_api.dart';
import 'package:network_api/apis/places_api.dart';
import 'package:network_api/apis/user_api.dart';
import 'package:network_api/apis/worker_application_api.dart';
import 'package:network_api/clients/dio_client.dart';
import 'package:network_api/clients/interceptor/auth_interceptor.dart';
import 'package:network_api/clients/interceptor/client_info_interceptor.dart';
import 'package:platform_timezone/platform_timezone.dart';

import '../di/di.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../repositories/ads/ads_repository_impl.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../repositories/auth/sign_in_repository_impl.dart';
import '../repositories/deep_links/deep_links_repository_impl.dart';
import '../repositories/order/order_activities_repository_impl.dart';
import '../repositories/order/order_candidate_repository_impl.dart';
import '../repositories/order/order_discovery_repository_impl.dart';
import '../repositories/order/order_placement_repository_impl.dart';
import '../repositories/order/order_repository_impl.dart';
import '../repositories/payment/place_payment_repository_impl.dart';
import '../repositories/payment/saved_payment_method_repository_impl.dart';
import '../repositories/payment/stripe_client_factory.dart';
import '../repositories/places/places_repository_impl.dart';
import '../repositories/translate/translate_repository_impl.dart';
import '../repositories/upload/upload_repository_impl.dart';
import '../repositories/user/user_repository_impl.dart';
import '../repositories/user_worker/user_worker_repository_impl.dart';
import '../services/location/location_service_impl.dart';
import '../services/storage/key_value_storage_local_impl.dart';
import 'platform_bootstrap.dart'
    if (dart.library.io) 'platform_bootstrap_mobile.dart'
    if (dart.library.html) 'platform_bootstrap_web.dart';

part 'bootstrap_analytics.dart';

part 'bootstrap_di.dart';

Future<void> bootstrap() async {
  GestureBinding.instance.resamplingEnabled = true;
  await platformBootstrap();
  await dotenv.load(fileName: "assets/env/app_variables.env");
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  await _bootstrapDi();
  await _bootstrapAnalytics();
}

final class Env {
  Env._();

  static String get env => dotenv.get("ENV");

  static String get baseUrl => dotenv.get("BASE_URL");

  static String? get amplitudeApiKey => dotenv.maybeGet("AMPLITUDE_API_KEY");

  static String? get googleCloudApiKey => dotenv.maybeGet("GOOGLE_CLOUD_API_KEY");

  static String get privacyPolicyUrl => 'https://mooov.io/privacy-policy';

  static String get supportEmail => 'support@mooova.io';

  static String get workerInfoUrl => 'https://mooova.io/mooover-info';

  static String get socialFacebookUrl => 'https://www.facebook.com/Mooova-109182837450101';

  static String get socialInstagramUrl => 'https://www.instagram.com/mooova_app';

  static String get socialLinkedinUrl => 'https://www.linkedin.com/company/mooova-app';
}
