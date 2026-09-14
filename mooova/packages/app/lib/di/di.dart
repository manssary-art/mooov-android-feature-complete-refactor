import '../repositories/ads/ads_repository.dart';
import '../repositories/auth/auth_repository.dart';
import '../repositories/auth/sign_in_repository.dart';
import '../repositories/deep_links/deep_links_repository.dart';
import '../repositories/order/order_activities_repository.dart';
import '../repositories/order/order_candidate_repository.dart';
import '../repositories/order/order_discovery_repository.dart';
import '../repositories/order/order_placement_repository.dart';
import '../repositories/order/order_repository.dart';
import '../repositories/payment/place_payment_repository.dart';
import '../repositories/payment/saved_payment_method_repository.dart';
import '../repositories/places/places_repository.dart';
import '../repositories/translate/translate_repository.dart';
import '../repositories/upload/upload_repository.dart';
import '../repositories/user/user_repository.dart';
import '../repositories/user_worker/user_worker_repository.dart';
import '../services/location/location_service.dart';

final class Di {
  Di._();

  /// Auth
  static late AuthRepository authRepository;
  static late SignInRepository signInRepository;

  /// User
  static late UserRepository userRepository;
  static late UserWorkerRepository userWorkerRepository;

  /// Order
  static late OrderRepository orderRepository;
  static late OrderDiscoveryRepository orderDiscoveryRepository;
  static late OrderActivitiesRepository orderActivitiesRepository;
  static late OrderCandidateRepository orderCandidateRepository;
  static late OrderPlacementRepository orderPlacementRepository;

  /// Payment
  static late PlacePaymentRepository placePaymentRepository;
  static late SavedPaymentMethodRepository savedPaymentMethodRepository;

  /// Utilities
  static late AdsRepository adsRepository;
  static late TranslateRepository translateRepository;
  static late DeepLinksRepository deepLinksRepository;
  static late UploadRepository uploadRepository;
  static late PlacesRepository placesRepository;
  static late LocationService locationService;
}
