import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/order_details/order_details_screen.dart' deferred as lazy_order_details_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/themed_transition_page.dart';
import '../authentication/authentication_route.dart';
import '../order_placement/order_placement_route.dart';
import '../utilities/images_viewer_route.dart';
import '../worker_application_form/worker_application_form_route.dart';

const _routePath = '/order/:orderId/details';

String orderDetailsPath({
  required String orderId,
}) =>
    Uri(
      path: _routePath.replaceFirst(':orderId', orderId),
    ).toString();

RouteBase orderDetailsRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_order_details_screen.loadLibrary,
          builder: (context) {
            final orderId = state.params['orderId']!;
            return lazy_order_details_screen.OrderDetailsScreen(
              orderId: orderId,
              onNavBack: () => context.popOrGo(),
              onNavToImagesViewer: (images, index) => showImageViewerBottomModalSheet(
                context: context,
                images: images,
                initialIndex: index,
              ),
              onNavToAuth: () => context.push(authenticationPath()),
              onNavToEditOrder: (orderId) => context.push(orderPlacementEditPath(orderId: orderId)),
              onNavToWorkerApplicationForm: () => context.push(workerApplicationFormPath()),
            );
          },
        ),
      ),
    );
