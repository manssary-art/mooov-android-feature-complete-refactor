import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/notification_settings/notification_settings_screen.dart'
    deferred as lazy_notification_settings_screen;
import '../../redirects/authentication_redirect.dart';
import '../../transitions/fade_transition_page.dart';
import '../authentication/authentication_route.dart';

const _routePath = '/notifications';

String notificationSettingsPath() => Uri(
      path: _routePath,
    ).toString();

RouteBase notificationSettingsRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireAuthenticatedRedirect(go: '/', push: authenticationPath()),
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_notification_settings_screen.loadLibrary,
          builder: (context) {
            return lazy_notification_settings_screen.NotificationSettingsScreen();
          },
        ),
      ),
    );
