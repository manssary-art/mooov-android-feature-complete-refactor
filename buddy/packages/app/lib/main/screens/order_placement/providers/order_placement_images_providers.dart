part of '_order_placement_providers.dart';

final imagesProvider = NotifierProvider<OrderPlacementImagesNotifier, List<(XFile? local, String? remote)>>(
  name: '$_name.imagesProvider',
  dependencies: _scope.dependencies,
  () => OrderPlacementImagesNotifier(),
).scoped(_scope);

class OrderPlacementImagesNotifier extends Notifier<List<(XFile? local, String? remote)>> {
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  List<(XFile?, String?)> build() {
    return ref.watch(orderPlacementProvider).value?.$2?.images?.map((e) => (null, e)).toList() ?? [];
  }

  void onAddImageClicked() async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    _sideEffect().add(OrderPlacementSideEffect$NavToImagePicker(key));
  }

  void onRemoveImageClicked(
    int index,
  ) async {
    state = state.minusAt(index);
  }

  void onImagePicked(String key, XFile file) async {
    state = state.plus((file, null));
    await ref.read(uploadRepositoryProvider).upload(file: file, type: UploadFolderType.product).onValue((url) {
      state = state.map((e) => e.$1 == file ? (file, url) : e).toList();
    }).onError((_, __) {
      state = state.minusWhere((e) => e.$1 == file);
    });
  }
}
