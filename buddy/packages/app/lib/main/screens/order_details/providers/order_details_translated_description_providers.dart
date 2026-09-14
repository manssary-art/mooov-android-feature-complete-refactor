part of '_order_details_providers.dart';

final translatedDescriptionProvider = NotifierProvider<OrderDetailsTranslatedDescriptionNotifier, String?>(
  name: '$_name.translatedDescriptionProvider',
  dependencies: _scope.dependencies,
  () => OrderDetailsTranslatedDescriptionNotifier(),
).scoped(_scope);

class OrderDetailsTranslatedDescriptionNotifier extends Notifier<String?> {
  late final _translateRepository = () => ref.read(translateRepositoryProvider);
  late final _description = () => ref.read(orderDetailsProvider).valueOrNull?.$2.description;

  @override
  String? build() {
    return null;
  }

  void onTranslateClicked(
    String targetLocale,
  ) async {
    final description = _description();
    if (description == null || description.trim().isEmpty) return;
    await _translateRepository().translate(value: description, targetLocale: targetLocale).onValue((e) => state = e);
  }
}