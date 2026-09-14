import 'package:core/core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../explore_ads_model.dart';

extension ExploreAdsDataSnapshotMapperExt on DataSnapshot {
  ExploreAdsModel? toExploreAdsModelOrNull() {
    final value = this.value;
    if (value is! Map) return null;
    final rootJson = Map<String, dynamic>.from(value);
    final gapCount = (rootJson['gap_count'] is int ? rootJson['gap_count'] : null) as int?;
    final content = (rootJson['content'] is Iterable ? rootJson['content'] : null) as Iterable?;
    if (gapCount == null || content == null) return null;
    final contentList = List.from(content).map((e) => Map<String, dynamic>.from(e));
    final ads = contentList.mapNotNull((e) {
      if (e['id'] == null || e['id'] is! String) return null;
      if (e['url'] == null || e['url'] is! String) return null;
      if (e['action'] == null || e['action'] is! String) return null;
      final id = e['id'] as String;
      final url = e['url'] as String;
      final actionType = e['action'] as String?;
      final locale = e['locale'] as String?;

      ExploreAdModelAction? action;
      switch (actionType) {
        case 'SHARE_PROFILE':
          action = ExploreAdModelAction$NavToProfile();
          break;
        case 'OPEN_URL':
          final actionContent = e['action_content'] as String?;
          if (actionContent == null) return null;
          action = ExploreAdModelAction$OpenUrl(actionContent);
          break;
      }

      return ExploreAdModel(
        id: id,
        imageUrl: url,
        action: action,
        locale: locale,
      );
    }).toList();

    if (ads.isEmpty) {
      return null;
    }

    return ExploreAdsModel(
      gap: gapCount,
      content: ads,
    );
  }
}
