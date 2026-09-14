part of '_explore_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<ExploreSideEffect>.broadcast(),
).scoped(_scope);

sealed class ExploreSideEffect {}

class ExploreSideEffect$NavToOrderDetails implements ExploreSideEffect {
  final String orderId;

  const ExploreSideEffect$NavToOrderDetails({required this.orderId});
}

class ExploreSideEffect$NavToProfile implements ExploreSideEffect {
  const ExploreSideEffect$NavToProfile();
}

class ExploreSideEffect$OpenUrl implements ExploreSideEffect {
  final String url;

  const ExploreSideEffect$OpenUrl({required this.url});
}
