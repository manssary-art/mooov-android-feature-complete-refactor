part of 'bootstrap.dart';

Future<void> _bootstrapDi() async {
  _bootstrapDioInterceptors();

  final baseUrl = Env.baseUrl;
  final unAuthedDio = await DioClient.unAuthedClient();
  final authedDio = await DioClient.authedClient(baseUrl: baseUrl);

  /// Service

  final locationServiceStorage = KeyValueStorageLocalImpl(await Hive.openBox('LocationServiceImpl'));
  Di.locationService = LocationServiceImpl(storage: locationServiceStorage);

  /// Auth

  Di.authRepository = AuthRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
  );
  Di.signInRepository = SignInRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
  );

  /// User

  final userApi = UserApi(authedDio);
  final workerApplicationApi = WorkerApplicationApi(authedDio);
  final onUserChanged = StreamController<UserModel>.broadcast();
  Di.userRepository = UserRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
    userApi: userApi,
    onUserChanged: onUserChanged,
  );
  Di.userWorkerRepository = UserWorkerRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
    userApi: userApi,
    workerApplicationApi: workerApplicationApi,
    onUserChanged: onUserChanged,
  );

  /// Order

  final onOrderChanged = StreamController<OrderModel>.broadcast();
  final orderApi = OrderApi(authedDio);
  Di.orderRepository = OrderRepositoryImpl(
    orderApi: orderApi,
    onOrderChanged: onOrderChanged,
  );

  final orderDiscoverApi = OrderDiscoverApi(authedDio);
  Di.orderDiscoveryRepository = OrderDiscoveryRepositoryImpl(
    orderDiscoverApi: orderDiscoverApi,
    locationService: Di.locationService,
    onOrderChanged: onOrderChanged,
  );

  final orderActivitiesApi = OrderActivitiesApi(authedDio);
  Di.orderActivitiesRepository = OrderActivitiesRepositoryImpl(
    orderActivitiesApi: orderActivitiesApi,
    userRepository: Di.userRepository,
    orderApi: orderApi,
    orderRepository: Di.orderRepository,
    onOrderChanged: onOrderChanged,
  );

  final orderManagementApi = OrderManagementApi(authedDio);
  Di.orderCandidateRepository = OrderCandidateRepositoryImpl(
    orderManagementApi: orderManagementApi,
    orderRepository: Di.orderRepository,
  );

  final orderPriceRecommendationApi = OrderPriceRecommendationApi(authedDio);
  Di.orderPlacementRepository = OrderPlacementRepositoryImpl(
    userRepository: Di.userRepository,
    orderPriceRecommendationApi: orderPriceRecommendationApi,
    orderApi: orderApi,
  );

  /// Payment

  final stripeClientFactory = StripeClientFactory();
  final paymentIntentApi = PaymentIntentApi(authedDio);
  Di.placePaymentRepository = PlacePaymentRepositoryImpl(
    userRepository: Di.userRepository,
    paymentIntentApi: paymentIntentApi,
    stripeClientFactory: stripeClientFactory,
    orderManagementApi: orderManagementApi,
  );

  final paymentCardApi = PaymentCardApi(authedDio);
  Di.savedPaymentMethodRepository = SavedPaymentMethodRepositoryImpl(
    paymentCardApi: paymentCardApi,
  );

  /// Utilities

  Di.adsRepository = AdsRepositoryImpl(
    firebaseDatabase: FirebaseDatabase.instance,
  );

  Di.translateRepository = TranslateRepositoryImpl(
    dio: unAuthedDio,
    googleCloudApiKey: Env.googleCloudApiKey!,
  );

  final placesApi = PlacesApi(unAuthedDio);
  Di.placesRepository = PlacesRepositoryImpl(
    placesApi: placesApi,
    googleCloudApiKey: Env.googleCloudApiKey!,
  );

  Di.deepLinksRepository = DeepLinksRepositoryImpl(
    firebaseDynamicLinks: FirebaseDynamicLinks.instance,
    base: 'https://link.mooov.io',
    packageName: 'com.mooov.mooov',
    bundleId: 'ai.mooov.mooov',
    storeId: '1512132548',
  );

  Di.uploadRepository = UploadRepositoryImpl(
    firebaseStorage: FirebaseStorage.instance,
    userRepository: Di.userRepository,
  );
}

Future<void> _bootstrapDioInterceptors() async {
  DioClientInfoInterceptor.getBuild = () async => '0';
  DioClientInfoInterceptor.getVersion = () async => '1.0.0';
  DioClientInfoInterceptor.getPlatform = () async => 'Web';
  DioClientInfoInterceptor.getTimezone = () async => PlatformTimezone.getPlatformTimezoneOrNull();
  DioClientInfoInterceptor.getLanguageCode = () async => 'en';
  DioAuthInterceptor.getAccessToken = (force) async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
    return FirebaseAuth.instance.currentUser?.getIdToken(force);
  };
}
