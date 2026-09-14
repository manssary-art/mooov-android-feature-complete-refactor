import 'dart:math';

import 'package:core/core.dart';

import '../../models/geo_point_model.dart';
import '../../models/order_address_model.dart';
import '../../models/order_model.dart';
import '../../models/payment_intent_model.dart';
import '../../models/types/order_size_type.dart';
import '../../models/types/order_state_type.dart';
import '../../models/types/order_type.dart';
import '../../models/types/payment_method_type.dart';
import '../../models/types/product_condition_type.dart';
import '../../models/types/user_level_type.dart';
import '../../models/types/user_notification_type.dart';
import '../../models/types/user_role_type.dart';
import '../../models/user_info_business_model.dart';
import '../../models/user_info_referral_model.dart';
import '../../models/user_info_worker_model.dart';
import '../../models/user_model.dart';

String get fakeImageUrl => 'https://picsum.photos/500?hash=${Random().nextInt(10)}';

UserModel fakeUserModel() {
  return UserModel(
    userId: 'userId',
    firstName: 'FirstName',
    lastName: 'LastName',
    phone: '+00000000000',
    image: fakeImageUrl,
    email: 'user.email@fakeapp.com',
    role: UserRole.worker,
    country: Country.SE,
    orderCounter: 10,
    fcmToken: null,
    geoPoint: const GeoPointModel(latitude: 59.332441, longitude: 18.064076),
    level: UserLevel.gold,
    mutedNotifications: [UserNotificationType.promotions],
    businessInfo: const UserInfoBusinessModel(
      name: 'UserBusinessName',
      vatNumber: '1234567890',
      address: 'business address',
      hasTrafficPermit: true,
    ),
    workerInfo: UserInfoWorkerModel(
      rating: 4.5,
      cutRate: 0.2,
      orderDeliverCounter: 20,
      vehiclesImagesUrls: [fakeImageUrl],
      tags: ['tag1', 'tag2', 'tag3', 'tag4', 'tag5', 'tag6'],
    ),
    referralInfo: UserInfoReferralModel(
      referralCode: 'ABC123',
      referralLink: fakeImageUrl,
      referredBy: 'userIdReferredBy',
    ),
    workerApplicationId: 'workerApplicationId',
  );
}

OrderModel fakeOrderModel() {
  final now = DateTime.now();
  final pickUpTimes = List.generate(5, (index) => now.add(Duration(hours: index)));
  final owner = fakeUserModel().copyWith(userId: () => 'ownerUserId', firstName: () => 'OwnerFirstName');
  final worker1 = fakeUserModel().copyWith(userId: () => 'workerUserId1', firstName: () => 'Worker1FirstName');
  final worker2 = fakeUserModel().copyWith(userId: () => 'workerUserId2', firstName: () => 'Worker2FirstName');
  final worker3 = fakeUserModel().copyWith(userId: () => 'workerUserId3', firstName: () => 'Worker3FirstName');
  return OrderModel(
    orderId: 'orderId',
    owner: owner,
    worker: worker1,
    candidates: {
      worker1: pickUpTimes.take(4).toList(),
      worker2: pickUpTimes.take(3).toList(),
      worker3: pickUpTimes.take(2).toList(),
    },
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
    currency: Currency.SEK,
    originalPrice: 10000,
    finalPrice: 12000,
    adminFee: 1000,
    images: [
      fakeImageUrl,
      fakeImageUrl,
      fakeImageUrl,
      fakeImageUrl,
    ],
    pickupImages: [
      fakeImageUrl,
      fakeImageUrl,
    ],
    deliveredImages: [
      fakeImageUrl,
      fakeImageUrl,
    ],
    deliveryAddresses: [
      fakeOrderAddressModel().copyWith(
        streetAddress: () => 'delivery streetAddress',
      ),
    ],
    pickupAddress: fakeOrderAddressModel().copyWith(
      streetAddress: () => 'pickup streetAddress',
    ),
    deliverTime: pickUpTimes.last,
    finalPickupTime: pickUpTimes.first,
    pickupTime: pickUpTimes,
    numOfWorkersRequested: 2,
    orderState: OrderState.created,
    orderType: OrderType.move,
    totalDistance: 10000,
    estimatedPrice: 9000,
    orderSize: OrderSize.l,
    productCondition: ProductCondition.good,
  );
}

OrderAddressModel fakeOrderAddressModel() {
  return const OrderAddressModel(
    streetAddress: 'streetAddress',
    area: 'Sollentuna',
    city: 'Stockholm',
    floor: '1',
    doorEntryCode: '1234',
    zipCode: '192 42',
    hasElevator: true,
    contactPhone: '+0000000000',
    country: Country.SE,
    assembly: false,
    geoPoint: GeoPointModel(latitude: 59.332441, longitude: 18.064076),
  );
}

PaymentIntentModel fakePaymentIntentModel() {
  return PaymentIntentModel(
    publishableKey: 'publishableKey',
    clientSecret: 'fake',
    orderId: 'orderId',
    totalAmount: 1000,
    discountAmount: 1000,
    vatAmount: 0,
    currency: Currency.SEK,
    type: PaymentMethodType.card,
    finalPickUpTime: DateTime.now(),
    workerId: 'workerId',
  );
}

