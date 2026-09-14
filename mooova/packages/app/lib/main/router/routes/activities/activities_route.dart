import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/activities/activities_screen.dart' deferred as lazy_activities_screen;
import '../../redirects/authentication_redirect.dart';
import '../../transitions/fade_transition_page.dart';
import '../authentication/authentication_route.dart';
import '../order_details/order_details_route.dart';
import '../order_rating/order_rating_route.dart';
import '../order_worker_selection/order_worker_selection_route.dart';

const _routePath = '/activities';

String activitiesPath() => Uri(
      path: _routePath,
    ).toString();

RouteBase activitiesRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireAuthenticatedRedirect(go: '/', push: authenticationPath()),
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_activities_screen.loadLibrary,
          builder: (context) {
            return lazy_activities_screen.ActivitiesScreen(
              onNavToOrderDetails: (orderId) => context.push(orderDetailsPath(orderId: orderId)),
              onNavToWorkerSelection: (orderId) => context.push(orderWorkerSelectionPath(orderId: orderId)),
              onNavToOrderRating: (orderId) => context.push(orderRatingPath(orderId: orderId)),
            );
          },
        ),
      ),
    );
