import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/mappers/date_time_mapper.dart';
import '../../../../screens/order_payment/order_payment_screen.dart' deferred as lazy_order_payment_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/themed_transition_page.dart';

const _routePath = '/order/:orderId/payment';

String orderPaymentPath({
  required String orderId,
  required String candidateId,
  required DateTime time,
}) =>
    Uri(
      path: _routePath.replaceFirst(':orderId', orderId),
      queryParameters: <String, String>{
        'c': candidateId,
        't': time.toDtoTimeInt().toString(),
      },
    ).toString();

RouteBase orderPaymentRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_order_payment_screen.loadLibrary,
          builder: (context) {
            final orderId = state.params['orderId']!;
            final candidateId = state.queryParams['c']!;
            final time = state.queryParams['t']!.toInt().toDateTime();
            return lazy_order_payment_screen.OrderPaymentScreen(
              onNavBack: () => context.popOrGo(),
              params: (candidateId: candidateId, orderId: orderId, time: time),
            );
          },
        ),
      ),
    );
