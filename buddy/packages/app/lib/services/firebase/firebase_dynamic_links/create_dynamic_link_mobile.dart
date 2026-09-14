import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String?> createShortLink({
  required FirebaseDynamicLinks firebaseDynamicLinks,
  required DynamicLinkParameters params,
}) async {
  return (await firebaseDynamicLinks.buildShortLink(params)).shortUrl.toString();
}
