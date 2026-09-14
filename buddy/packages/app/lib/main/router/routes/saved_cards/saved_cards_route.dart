import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../screens/saved_cards/saved_cards_screen.dart' deferred as lazy_saved_cards_screen;
import '../../redirects/authentication_redirect.dart';
import '../../transitions/fade_transition_page.dart';
import '../authentication/authentication_route.dart';

const _routePath = '/saved-cards';

String savedCardsPath() => Uri(
      path:_routePath,
    ).toString();

RouteBase savedCardsRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireAuthenticatedRedirect(go: '/', push: authenticationPath()),
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_saved_cards_screen.loadLibrary,
          builder: (context) {
            return lazy_saved_cards_screen.SavedCardsScreen();
          },
        ),
      ),
    );
