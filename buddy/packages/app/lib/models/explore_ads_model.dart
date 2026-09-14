import 'package:equatable/equatable.dart';

class ExploreAdsModel with EquatableMixin {
  final int gap;
  final List<ExploreAdModel> content;

  ExploreAdsModel({
    required this.gap,
    required this.content,
  });

  @override
  List<Object?> get props => [
        gap,
        content,
      ];

  ExploreAdsModel copyWith({
    int Function()? gap,
    List<ExploreAdModel> Function()? content,
  }) {
    return ExploreAdsModel(
      gap: gap != null ? gap() : this.gap,
      content: content != null ? content() : this.content,
    );
  }
}

class ExploreAdModel with EquatableMixin {
  final String id;
  final String imageUrl;
  final ExploreAdModelAction? action;
  final String? locale;

  ExploreAdModel({
    required this.id,
    required this.imageUrl,
    required this.action,
    required this.locale,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        action,
        locale,
      ];

  ExploreAdModel copyWith({
    String Function()? id,
    String Function()? imageUrl,
    ExploreAdModelAction? Function()? action,
    String? Function()? locale,
  }) {
    return ExploreAdModel(
      id: id != null ? id() : this.id,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
      action: action != null ? action() : this.action,
      locale: locale != null ? locale() : this.locale,
    );
  }
}

sealed class ExploreAdModelAction with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ExploreAdModelAction$NavToProfile extends ExploreAdModelAction {}

class ExploreAdModelAction$OpenUrl extends ExploreAdModelAction {
  final String url;

  ExploreAdModelAction$OpenUrl(this.url);

  @override
  List<Object?> get props => [url];
}
