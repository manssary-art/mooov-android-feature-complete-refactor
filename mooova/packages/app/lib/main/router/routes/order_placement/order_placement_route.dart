import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/types/order_type.dart';
import '../../../../screens/order_placement/models/order_placement_mode.dart';
import '../../../../screens/order_placement/order_placement_screen.dart' deferred as lazy_order_placement_screen;
import '../../ext/go_router_ext.dart';
import '../../transitions/themed_transition_page.dart';
import '../utilities/address_picker_route.dart';
import '../utilities/image_picker_route.dart';

const _routePath = '/order-placement';

String orderPlacementNewPath({
  required OrderType type,
}) =>
    _orderPlacementPath(
      type: type,
      mode: 'n',
    );

String orderPlacementEditPath({
  required String orderId,
}) =>
    _orderPlacementPath(
      orderId: orderId,
      mode: 'e',
    );

String orderPlacementDuplicatePath({
  required String orderId,
}) =>
    _orderPlacementPath(
      orderId: orderId,
      mode: 'd',
    );

String _orderPlacementPath({
  String? orderId,
  OrderType? type,
  required String mode,
}) =>
    Uri(path: _routePath, queryParameters: <String, String>{
      ...orderId?.let((it) => {'orderId': it}) ?? {},
      ...type?.index.toInt().toString()?.let((it) => {'type': it}) ?? {},
      'mode': mode,
    }).toString();

RouteBase orderPlacementRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (context, state) => ThemedTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_order_placement_screen.loadLibrary,
          builder: (context) {
            final modeValue = state.queryParams['mode'];
            final orderId = state.queryParams['orderId'];
            final index = state.queryParams['type']?.toString().toIntOrNull() ?? -1;
            final type = OrderType.values.getAtOrNull(index);

            OrderPlacementMode? mode;
            if (modeValue == 'n' && type != null) {
              mode = OrderPlacementMode$New(type);
            } else if (modeValue == 'e' && orderId != null) {
              mode = OrderPlacementMode$Edit(orderId, false);
            } else if (modeValue == 'd' && orderId != null) {
              mode = OrderPlacementMode$Edit(orderId, true);
            }

            if (mode == null) {
              Future.microtask(() => context.popOrGo(location: '/'));
              return Container();
            }

            return lazy_order_placement_screen.OrderPlacementScreen(
              mode: mode,
              onNavBack: () => context.popOrGo(location: '/'),
              onNavToImagePicker: () => showImagePickerBottomModalSheet(context: context),
              onNavToAddressPicker: () => showAddressPickerBottomModalSheet(context: context),
            );
          },
        ),
      ),
    );
