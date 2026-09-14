import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodObserver extends ProviderObserver {
  static void Function(String, Object, StackTrace?) onError = (_, __, ___) {};

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    onError(provider.name ?? provider.toString(), error, stackTrace);
  }
}
