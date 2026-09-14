import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'create_dynamic_link_stub.dart'
    if (dart.library.html) 'create_dynamic_link_web.dart'
    if (dart.library.io) 'create_dynamic_link_mobile.dart' as create_dynamic_link_mobile;

extension FirebaseDynamicLinksExt on FirebaseDynamicLinks {
  Future<String?> createShortLink(DynamicLinkParameters params) async {
    return await create_dynamic_link_mobile.createShortLink(
      firebaseDynamicLinks: this,
      params: params,
    );
  }
}
