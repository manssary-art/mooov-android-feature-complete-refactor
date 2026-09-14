import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/profile/profile_screen.dart' deferred as lazy_profile_screen;
import '../../redirects/authentication_redirect.dart';
import '../../transitions/fade_transition_page.dart';
import '../authentication/authentication_route.dart';
import '../notification_settings/notification_settings_route.dart';
import '../saved_cards/saved_cards_route.dart';
import '../utilities/image_picker_route.dart';
import '../worker_application_form/worker_application_form_route.dart';

const _routePath = '/profile';

String profilePath() => Uri(
      path: _routePath,
    ).toString();

RouteBase profileRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireAuthenticatedRedirect(go: '/', push: authenticationPath()),
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_profile_screen.loadLibrary,
          builder: (context) {
            return lazy_profile_screen.ProfileScreen(
              onNavToImagePicker: () => showImagePickerBottomModalSheet(context: context),
              onNavToHome: () => context.go('/'),
              onNavToNotificationSettings: () => context.go(notificationSettingsPath()),
              onNavToSavedCards: () => context.go(savedCardsPath()),
              onNavToWorkerApplicationForm: () => context.go(workerApplicationFormPath()),
            );
          },
        ),
      ),
    );
