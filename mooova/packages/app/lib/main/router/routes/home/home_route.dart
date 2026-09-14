import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/home/home_screen.dart' deferred as lazy_home_screen;
import '../../transitions/fade_transition_page.dart';
import '../order_placement/order_placement_route.dart';

const _routePath = '/home';

String homePath() => Uri(
      path: _routePath,
    ).toString();

RouteBase homeRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_home_screen.loadLibrary,
          builder: (context) {
            return lazy_home_screen.HomeScreen(
              onNavToOrderPlacement: (type) => context.push(orderPlacementNewPath(type: type)),
            );
          },
        ),
      ),
    );
