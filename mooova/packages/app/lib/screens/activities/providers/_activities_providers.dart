import 'dart:async';

import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../repositories/upload/upload_repository.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../ext/order_model_ext.dart';
import '../models/activities_order_item.dart';
import '../models/activities_tab.dart';

part 'activities_side_effects_providers.dart';

part 'activities_state_providers.dart';

const _name = 'Activities';

final _scope = ProviderScopeContainer();

final orderActivitiesRepositoryProvider = Provider((ref) => Di.orderActivitiesRepository);

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final uploadRepositoryProvider = Provider((ref) => Di.uploadRepository);

final activitiesProvider = StreamNotifierProvider<ActivitiesNotifier, List<ActivitiesOrderItem>>(
  name: '$_name.activitiesProvider',
  dependencies: _scope.dependencies,
  () => ActivitiesNotifier(),
).scoped(_scope);

class ActivitiesNotifier extends StreamNotifier<List<ActivitiesOrderItem>> {
  late final _sideEffects = () => ref.read(sideEffectProvider);

  @override
  Stream<List<ActivitiesOrderItem>> build() async* {
    final userRepository = ref.watch(userRepositoryProvider);
    final orderActivitiesRepository = ref.watch(orderActivitiesRepositoryProvider);
    final startWithUserIdResult = await userRepository.getUserIdOrNull();
    final startWithOrdersResult = await orderActivitiesRepository.getRelatedOrders();

    final stream = Rx.combineLatest2(
      userRepository.onUserChanged
          .asyncMap((e) async => startWithUserIdResult.asValue)
          .startWith(await userRepository.getUserIdOrNull().asValue)
          .map((e) => e!.value),
      orderActivitiesRepository.onRelatedOrdersChanged.startWith(startWithOrdersResult.asValue!.value ?? []),
      (userId, orders) => (userId, orders),
    );

    await for (final (userId, orders) in stream) {
      if (userId != null) {
        yield orders.mapNotNull((e) => e.toActivitiesOrderItemOrNull(userId)).toList();
      } else {
        state = const AsyncValue.loading();
      }
    }
  }

  void onPullToRefresh() async {
    if (state.isLoading || state.isRefreshing) return;
    ref.invalidateSelf();
  }

  Future<void> onOwnerIncreasePriceClicked(String orderId) async {
    final orderActivitiesRepository = ref.read(orderActivitiesRepositoryProvider);
    final item = state.requireValue
        .whereType<ActivitiesOrderItem$Owner$Created>()
        .firstWhere((e) => e.order.orderId == orderId);
    final newPrice = item.order.finalPrice + item.priceIncreaseAmount;

    await orderActivitiesRepository.increaseOrderPrice(orderId: orderId, newPrice: newPrice);
    ref.invalidateSelf();
  }

  void onOwnerPhoneCallWorkerClicked(String orderId) {
    final item = state.requireValue.whereType<ActivitiesOrderItem$Owner>().firstWhere((e) => e.order.orderId == orderId);
    final phone = item.order.worker?.phone;
    if (phone == null) return;
    _sideEffects().add(ActivitiesSideEffect$OpenUrl(url: 'tel:$phone'));
  }

  void onOwnerPhoneSmsWorkerClicked(String orderId) {
    final item = state.requireValue.whereType<ActivitiesOrderItem$Owner>().firstWhere((e) => e.order.orderId == orderId);
    final phone = item.order.worker?.phone;
    if (phone == null) return;
    _sideEffects().add(ActivitiesSideEffect$OpenUrl(url: 'sms:$phone'));
  }

  void onWorkerPhoneCallOwnerClicked(String orderId) {
    final item = state.requireValue.whereType<ActivitiesOrderItem$Worker>().firstWhere((e) => e.order.orderId == orderId);
    final phone = item.order.owner.phone;
    if (phone == null) return;
    _sideEffects().add(ActivitiesSideEffect$OpenUrl(url: 'tel:$phone'));
  }

  void onWorkerPhoneSmsOwnerClicked(String orderId) {
    final item = state.requireValue.whereType<ActivitiesOrderItem$Worker>().firstWhere((e) => e.order.orderId == orderId);
    final phone = item.order.owner.phone;
    if (phone == null) return;
    _sideEffects().add(ActivitiesSideEffect$OpenUrl(url: 'sms:$phone'));
  }

  Future<void> onOwnerDeliveryDoneClicked(String orderId) async {
    final orderActivitiesRepository = ref.read(orderActivitiesRepositoryProvider);
    await orderActivitiesRepository.confirmDelivery(orderId: orderId);
    ref.invalidateSelf();
  }

  void onWorkerUploadPickedUpImageClicked(String orderId) {
    _sideEffects().add(
      ActivitiesSideEffect$NavToImagePicker(orderId: orderId, type: ActivitiesImageUploadType.pickup),
    );
  }

  void onWorkerUploadDeliveredImageClicked(String orderId) {
    _sideEffects().add(
      ActivitiesSideEffect$NavToImagePicker(orderId: orderId, type: ActivitiesImageUploadType.delivered),
    );
  }

  Future<void> onImagePicked({
    required String orderId,
    required ActivitiesImageUploadType type,
    required XFile file,
  }) async {
    final uploadRepository = ref.read(uploadRepositoryProvider);
    final orderActivitiesRepository = ref.read(orderActivitiesRepositoryProvider);

    final uploadResult = await uploadRepository.upload(file: file, type: UploadFolderType.order);

    await uploadResult.onValue((url) async {
      switch (type) {
        case ActivitiesImageUploadType.pickup:
          await orderActivitiesRepository.setOrderPickedUp(orderId: orderId, pickupImages: [url]);
        case ActivitiesImageUploadType.delivered:
          await orderActivitiesRepository.setOrderDelivered(orderId: orderId, deliveredImages: [url]);
      }
    });

    ref.invalidateSelf();
  }
}
