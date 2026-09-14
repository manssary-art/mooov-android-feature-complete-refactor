import 'package:core/core.dart';
import 'package:network_api/dtos/address_contact_dto.dart';
import 'package:network_api/dtos/address_dto.dart';
import 'package:network_api/dtos/geo_point_dto.dart';
import 'package:network_api/dtos/order_dto.dart';

import '../order_address_model.dart';
import '../order_model.dart';
import '../types/order_size_type.dart';
import '../types/order_state_type.dart';
import '../types/order_type.dart';
import '../types/product_condition_type.dart';
import 'date_time_mapper.dart';
import 'geo_point_mapper.dart';
import 'user_mapper.dart';

extension OrderDtoMapperExt on OrderDto {
  OrderModel? toOrderModelOrNull() {
    final owner = this.owner;
    final worker = this.worker;
    final orderState = this.orderState.toOrderStateOrNull();
    final orderType = this.orderType.toOrderTypeOrNull();
    if (owner == null || orderState == null || orderType == null) {
      return null;
    }

    final shouldHaveWorker = switch (orderState) {
      OrderState.created => false,
      OrderState.assigned => true,
      OrderState.delivered => true,
      OrderState.completed => true,
      OrderState.expired => false,
      OrderState.refunded => false,
    };

    if (worker == null && shouldHaveWorker) {
      return null;
    }

    return OrderModel(
      orderId: orderId,
      owner: owner.toUserModel(),
      worker: worker?.toUserModel(),
      candidates: candidates?.asMap().mapNotNull((key, value) {
        if (value.worker == null) return null;
        final worker = value.worker!.toUserModel();
        final pickupTimes = value.pickupTime.toDateTimes();
        return MapEntry(worker, pickupTimes);
      }),
      description: description,
      currency: currencyCode?.toCurrencyOrNull() ?? Currency.EUR,
      originalPrice: originalPrice,
      finalPrice: finalPrice ?? 0.0,
      adminFee: adminFee,
      images: images,
      pickupImages: pickupImages,
      deliveredImages: deliveredImages,
      deliveryAddresses: deliveryAddresses?.map((e) => e.toOrderAddressModel()).toList(),
      pickupAddress: pickupAddress?.toOrderAddressModel(),
      deliverTime: deliverTime?.toDateTime(),
      finalPickupTime: finalPickupTime?.toDateTime(),
      pickupTime: pickupTime?.toDateTimes(),
      numOfWorkersRequested: numOfWorkersRequested,
      orderState: orderState,
      orderType: orderType,
      totalDistance: totalDistance,
      estimatedPrice: estimatedPrice,
      orderSize: orderSize.toOrderSizeOrNull() ?? OrderSize.l,
      productCondition: itemCondition?.toProductConditionTypeOrNull() ?? ProductCondition.veryGood,
    );
  }
}

extension OrderAddressDtoMapperExt on AddressDto {
  OrderAddressModel toOrderAddressModel() => OrderAddressModel(
        streetAddress: streetAddress,
        area: area,
        city: city,
        floor: floor,
        doorEntryCode: doorEntryCode,
        zipCode: zipCode,
        hasElevator: hasElevator,
        contactPhone: contact?.phone,
        geoPoint: geoPoint.toGeoPointModel(),
        country: countryCode?.toCountryOrNull(),
        assembly: null,
      );
}

extension OrderAddressModelMapperExt on OrderAddressModel {
  AddressDto toAddressDto() => AddressDto(
        streetAddress: streetAddress!,
        area: area,
        city: city,
        floor: floor,
        doorEntryCode: doorEntryCode,
        zipCode: zipCode,
        countryCode: country?.code,
        hasElevator: hasElevator,
        contact: contactPhone?.let((it) => AddressContactDto(phone: it)),
        geoPoint: GeoPointDto(latitude: geoPoint!.latitude, longitude: geoPoint!.longitude),
        apartmentNumber: null,
      );
}
