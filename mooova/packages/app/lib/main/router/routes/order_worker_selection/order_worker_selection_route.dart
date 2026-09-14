import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../screens/order_worker_selection/order_worker_selection_screen.dart'
    deferred as lazy_order_worker_selection_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/themed_transition_page.dart';
import '../payment/order_payment_route.dart';
import '../utilities/images_viewer_route.dart';

const _routePath = '/order/:orderId/candidates';

String orderWorkerSelectionPath({
  required String orderId,
}) =>
    Uri(
      path: _routePath.replaceFirst(':orderId', orderId),
    ).toString();

RouteBase orderWorkerSelectionRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_order_worker_selection_screen.loadLibrary,
          builder: (context) {
            final orderId = state.params['orderId']!;
            return lazy_order_worker_selection_screen.OrderWorkerSelectionScreen(
              orderId: orderId,
              onNavBack: () => context.popOrGo(),
              onNavToImagesViewer: (images, index) => showImageViewerBottomModalSheet(
                context: context,
                images: images,
                initialIndex: index,
              ),
              onNavToPayment: (candidateId, time) => context.push(orderPaymentPath(
                orderId: orderId,
                candidateId: candidateId,
                time: time,
              )),
            );
          },
        ),
      ),
    );
