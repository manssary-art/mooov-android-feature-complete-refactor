import 'integrations/amplitude/amplitude_integration.dart';
import 'integrations/facebook/facebook_integration.dart';

abstract class AnalyticsEvent {
  factory AnalyticsEvent.onUserRegister() {
    return const AnalyticsEventData('tap_submit_registration');
  }

  factory AnalyticsEvent.onIncreaseOrderPrice() {
    return const AnalyticsEventData('tap_increase_price');
  }

  factory AnalyticsEvent.onPlaceOrderImagesDone() {
    return const AnalyticsEventData('tap_next_on_camera_page');
  }

  factory AnalyticsEvent.onPlaceOrderAddressesDone() {
    return const AnalyticsEventData('tap_next_on_delivery_info_page');
  }

  factory AnalyticsEvent.onPlaceOrderPriceDone() {
    return const AnalyticsEventData('tap_next_on_pricing_page');
  }

  factory AnalyticsEvent.onPlaceOrderReviewDone(double price) {
    final params = {'purchase amount': price};
    return AnalyticsEventBundle([
      AnalyticsEventData('tap_publish_summary_page', params: params),
      AnalyticsEventData('fb_mobile_purchase', params: params, integration: FacebookAnalyticsIntegrations.id),
    ]);
  }

  factory AnalyticsEvent.onMarkOrderCompleted() {
    return const AnalyticsEventBundle([
      AnalyticsEventData('tap_confirm_completed'),
      AnalyticsEventData('fb_mobile_achievement_unlocked', integration: FacebookAnalyticsIntegrations.id),
    ]);
  }

  factory AnalyticsEvent.onSelectMooover() {
    return const AnalyticsEventData('tap_select_mooover');
  }

  factory AnalyticsEvent.onProfileInviteFriend() {
    return const AnalyticsEventData('tap_invite_friends_profile_page');
  }

  factory AnalyticsEvent.onApplyPromoCode(String code) {
    final params = {'code': code};
    return AnalyticsEventData('tap_apply_promo_code', params: params);
  }

  factory AnalyticsEvent.onCompletePayment() {
    return const AnalyticsEventData('tap_complete_payment');
  }

  factory AnalyticsEvent.onStartCreation({required String orderType}) {
    final params = {'order_type': orderType.toLowerCase()};
    return AnalyticsEventBundle([
      AnalyticsEventData('tap_start_creation', params: params),
      const AnalyticsEventData('fb_mobile_add_to_cart', integration: FacebookAnalyticsIntegrations.id),
    ]);
  }

  factory AnalyticsEvent.onTapDiscoverOrder({required String orderId}) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_discover_order', params: params);
  }

  factory AnalyticsEvent.onTapProfileLogout() {
    return const AnalyticsEventData('tap_profile_logout');
  }

  factory AnalyticsEvent.onTapProfilePaymentMethod() {
    return const AnalyticsEventData('tap_profile_payment_method');
  }

  factory AnalyticsEvent.onTapProfileJoinMooova() {
    return const AnalyticsEventData('tap_profile_join_mooova');
  }

  factory AnalyticsEvent.onTapProfileHeaderJoinMooova() {
    return const AnalyticsEventData('tap_profile_header_join_mooova');
  }

  factory AnalyticsEvent.onTapOrderDetailsJoinMooova(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_order_detail_join_mooova', params: params);
  }

  factory AnalyticsEvent.onTapOrderDetailsDeleteOrder(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_order_details_delete_order', params: params);
  }

  factory AnalyticsEvent.onTapActivitiesRateOrder(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_activities_rate_order', params: params);
  }

  factory AnalyticsEvent.onTapActivitiesCallOwner(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_activities_call_owner', params: params);
  }

  factory AnalyticsEvent.onTapActivitiesCallMooover(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_activities_call_mooover', params: params);
  }

  factory AnalyticsEvent.onTapActivitiesTextOwner(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_activities_text_owner', params: params);
  }

  factory AnalyticsEvent.onTapActivitiesTextMooover(String orderId) {
    final params = {'id': orderId};
    return AnalyticsEventData('tap_activities_text_mooover', params: params);
  }

  factory AnalyticsEvent.onHomeButtonIconExperiment(bool variant) {
    final params = {'variant': variant};
    return AnalyticsEventData('home_button_icon_experiment',
        params: params, integration: AmplitudeAnalyticsIntegration.id);
  }
}

class AnalyticsEventBundle implements AnalyticsEvent {
  final List<AnalyticsEvent> events;

  const AnalyticsEventBundle(this.events);
}

class AnalyticsEventData implements AnalyticsEvent {
  final String event;
  final String? integration;
  final Map<String, dynamic>? params;

  const AnalyticsEventData(this.event, {this.integration, this.params});
}
