part of '_activities_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<ActivitiesSideEffect>.broadcast(),
).scoped(_scope);

sealed class ActivitiesSideEffect {}

class ActivitiesSideEffect$NavToProfile implements ActivitiesSideEffect {
  const ActivitiesSideEffect$NavToProfile();
}

class ActivitiesSideEffect$OpenUrl implements ActivitiesSideEffect {
  final String url;

  const ActivitiesSideEffect$OpenUrl({required this.url});
}

enum ActivitiesImageUploadType { pickup, delivered }

class ActivitiesSideEffect$NavToImagePicker implements ActivitiesSideEffect {
  final String orderId;
  final ActivitiesImageUploadType type;

  const ActivitiesSideEffect$NavToImagePicker({
    required this.orderId,
    required this.type,
  });
}
