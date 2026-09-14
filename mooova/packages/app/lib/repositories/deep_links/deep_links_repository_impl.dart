import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../services/firebase/firebase_dynamic_links/create_dynamic_link.dart';
import 'deep_links_repository.dart';

class DeepLinksRepositoryImpl implements DeepLinksRepository {
  final FirebaseDynamicLinks firebaseDynamicLinks;
  final String base;
  final String packageName;
  final String bundleId;
  final String storeId;

  DeepLinksRepositoryImpl({
    required this.firebaseDynamicLinks,
    required this.base,
    required this.packageName,
    required this.bundleId,
    required this.storeId,
  });

  @override
  Future<Result<String>> getDeepLinkForOrderId({
    required String orderId,
  }) =>
      resultOf(() async {
        final dynamicLinkParams = DynamicLinkParameters(
          link: Uri.parse("https://www.mooov.io?orderId=$orderId"),
          androidParameters: AndroidParameters(
            packageName: packageName,
          ),
          iosParameters: IOSParameters(
            bundleId: bundleId,
            appStoreId: storeId,
          ),
          uriPrefix: base,
        );

        final link =
            await firebaseDynamicLinks.createShortLink(dynamicLinkParams);
        if (link != null) {
          return Result.value(link);
        } else {
          return Result.error(Exception('link == null'));
        }
      });
}
