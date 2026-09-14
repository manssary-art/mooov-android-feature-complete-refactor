import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationPermissionRequestScreen extends HookConsumerWidget {
  final void Function() onNavBack;
  final Future<bool> Function() requestPermission;

  const LocationPermissionRequestScreen({
    super.key,
    required this.onNavBack,
    required this.requestPermission,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                LocaleKeys.Mooov.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Assets.images.imageMapMarketClouds.image(
                  height: 192,
                  width: 192,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Text(
                    LocaleKeys.AllowLocation.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 40, right: 40),
                  child: Text(
                    LocaleKeys.AllowLocationDes.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: () async {
                    final granted = await requestPermission();
                    if (granted == true) {
                      onNavBack();
                    }
                  },
                  child: Text(LocaleKeys.AllowLocationButton.tr()),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: OutlinedButton(
                    onPressed: onNavBack,
                    child: Text(LocaleKeys.NotNowButton.tr()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
