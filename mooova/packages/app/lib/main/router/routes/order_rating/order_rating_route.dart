import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/order_rating/order_rating_screen.dart' deferred as lazy_order_rating_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/themed_transition_page.dart';

const _routePath = '/order/:orderId/rating';

String orderRatingPath({required String orderId}) =>
    Uri(path: _routePath.replaceFirst(':orderId', orderId)).toString();

RouteBase orderRatingRoute({required GlobalKey<NavigatorState>? parentNavigatorKey}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_order_rating_screen.loadLibrary,
          builder: (context) {
            final orderId = state.params['orderId']!;
            return lazy_order_rating_screen.OrderRatingScreen(
              orderId: orderId,
              onNavBack: () => context.popOrGo(),
            );
          },
        ),
      ),
    );
