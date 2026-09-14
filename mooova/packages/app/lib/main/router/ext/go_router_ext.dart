import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension GoRouterHelperExt on BuildContext {
  Future<T?> pushPage<T extends Object?>(
    Page<T> page,
  ) =>
      Navigator.of(this).push(
        page.createRoute(this),
      );

  Future<void> popOrGo({
    String location = '/',
  }) async {
    if (canPop()) {
      pop();
    } else {
      go(location);
    }
  }

  void pushToExternalUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
  }
}
