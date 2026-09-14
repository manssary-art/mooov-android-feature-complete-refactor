import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/authentication/authentication_screen.dart' deferred as lazy_authentication_screen;
import '../../ext/go_router_ext.dart';
import '../../redirects/authentication_redirect.dart';
import '../../transitions/themed_transition_page.dart';
import '../utilities/country_picker_route.dart';

const _routePath = '/auth';

String authenticationPath() => Uri(
      path: _routePath,
    ).toString();

RouteBase authenticationRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireUnauthenticatedRedirect(go: '/'),
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_authentication_screen.loadLibrary,
          builder: (context) {
            return lazy_authentication_screen.AuthenticationScreen(
              onNavBack: () => context.popOrGo(),
              onNavToCountryPicker: (initial) => showCountryPickerBottomModalSheet(
                context: context,
                initial: initial,
              ),
            );
          },
        ),
      ),
    );
