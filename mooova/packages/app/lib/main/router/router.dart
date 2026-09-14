import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/app_update/app_update_screen.dart' deferred as lazy_app_update_screen;
import '../../screens/order_payment/order_payment_screen.dart' deferred as lazy_order_payment_screen;
import '../../screens/order_rating/order_rating_screen.dart' deferred as lazy_order_rating_screen;
import '../../screens/wizard/wizard_screen.dart' deferred as lazy_wizard_screen;
import 'router_observer.dart';
import 'routes/activities/activities_route.dart';
import 'routes/authentication/authentication_route.dart';
import 'routes/explore/explore_route.dart';
import 'routes/home/home_route.dart';
import 'routes/notification_settings/notification_settings_route.dart';
import 'routes/order_details/order_details_route.dart';
import 'routes/order_placement/order_placement_route.dart';
import 'routes/order_worker_selection/order_worker_selection_route.dart';
import 'routes/payment/order_payment_route.dart';
import 'routes/profile/profile_route.dart';
import 'routes/root/page_not_found_screen.dart';
import 'routes/root/root_screen.dart' deferred as lazy_root_screen;
import 'routes/saved_cards/saved_cards_route.dart';
import 'routes/worker_application_form/worker_application_form_route.dart';
import 'transitions/themed_transition_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = _appRouter();

GoRouter _appRouter() => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      redirectLimit: 10,
      errorBuilder: (context, state) => PageNotFoundScreen(
        onNavToRoot: () => context.go('/'),
      ),
      observers: [
        RouterObserver(),
      ],
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) => '/home',
          parentNavigatorKey: _rootNavigatorKey,
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => DeferredBuilder(
            loadLibrary: lazy_root_screen.loadLibrary,
            builder: (context) {
              final router = GoRouter.of(context);
              final location = router.location;
              return lazy_root_screen.RootScreen(
                currentIndex: location.let((it) {
                  if (it.startsWith(homePath())) return 0;
                  if (it.startsWith(explorePath())) return 1;
                  if (it.startsWith(activitiesPath())) return 2;
                  if (it.startsWith(profilePath())) return 3;
                  return null;
                }),
                onTap: (index) => index.run((it) {
                  if (it == 0) router.go(homePath());
                  if (it == 1) router.go(explorePath());
                  if (it == 2) router.go(activitiesPath());
                  if (it == 3) router.go(profilePath());
                }),
                child: child,
              );
            },
          ),
          routes: [
            homeRoute(
              parentNavigatorKey: _shellNavigatorKey,
            ),
            exploreRoute(
              parentNavigatorKey: _shellNavigatorKey,
            ),
            activitiesRoute(
              parentNavigatorKey: _shellNavigatorKey,
            ),
            profileRoute(
              parentNavigatorKey: _shellNavigatorKey,
            ),
          ],
        ),
        GoRoute(
          path: '/app-update',
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) => ThemedTransitionPage(
            key: state.pageKey,
            child: DeferredBuilder(
              loadLibrary: lazy_app_update_screen.loadLibrary,
              builder: (context) {
                return lazy_app_update_screen.AppUpdateScreen();
              },
            ),
          ),
        ),
        authenticationRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        orderDetailsRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        GoRoute(
          path: '/order-rating',
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) => ThemedTransitionPage(
            key: state.pageKey,
            child: DeferredBuilder(
              loadLibrary: lazy_order_rating_screen.loadLibrary,
              builder: (context) {
                return lazy_order_rating_screen.OrderRatingScreen();
              },
            ),
          ),
        ),
        GoRoute(
          path: '/wizard',
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) => ThemedTransitionPage(
            key: state.pageKey,
            child: DeferredBuilder(
              loadLibrary: lazy_wizard_screen.loadLibrary,
              builder: (context) {
                return lazy_wizard_screen.WizardScreen();
              },
            ),
          ),
        ),
        orderPaymentRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        orderWorkerSelectionRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        notificationSettingsRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        savedCardsRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        workerApplicationFormRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
        orderPlacementRoute(
          parentNavigatorKey: _rootNavigatorKey,
        ),
      ],
    );
