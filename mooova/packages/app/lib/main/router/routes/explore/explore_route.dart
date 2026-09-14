import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/explore/explore_screen.dart' deferred as lazy_explore_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/fade_transition_page.dart';
import '../order_details/order_details_route.dart';
import '../profile/profile_route.dart';

const _routePath = '/explore';

String explorePath() => Uri(
      path: _routePath,
    ).toString();

RouteBase exploreRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_explore_screen.loadLibrary,
          builder: (context) {
            return lazy_explore_screen.ExploreScreen(
              onNavToOrderDetails: (orderId) => context.push(orderDetailsPath(orderId: orderId)),
              onNavToProfile: () => context.push(profilePath()),
              onNavToExternalUrl: (url) => context.pushToExternalUrl(url),
            );
          },
        ),
      ),
    );
