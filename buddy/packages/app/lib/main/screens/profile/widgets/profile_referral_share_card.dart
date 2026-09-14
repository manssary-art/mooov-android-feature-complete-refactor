import 'dart:io';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:design_system/extensions/material_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../models/types/user_role_type.dart';

const _userShareBackgroundColor = Color(0xFF17B1BB);
const _workerShareBackgroundColor = Color(0xFF07A5F6);

class ProfileShareCard extends HookWidget {
  final String? payload;
  final Country? country;
  final UserRole role;
  final void Function() onShareClicked;
  final void Function() onImageShareClicked;

  const ProfileShareCard({
    super.key,
    required this.payload,
    required this.country,
    required this.role,
    required this.onShareClicked,
    required this.onImageShareClicked,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).scaffoldBackgroundColor);
    const shareButtonHeight = 32.0;
    final shareTextStyle = Theme.of(context).textTheme.titleLarge;
    final disclaimerWidget = buildDisclaimer(context);
    final getQrCodeSize = (BoxConstraints box) => box.maxWidth * 0.25;
    final getQrCodeContainerWidth = (BoxConstraints box) => box.maxWidth * 0.7;
    final cardKey = useMemoized(() => GlobalKey());
    final qrKey = useMemoized(() => GlobalKey());
    final cardHeight = useState<double?>(null);

    void onLayout() {
      final obj = qrKey.currentContext?.findRenderObject();
      final RenderBox? renderBoxRed = obj is RenderBox ? obj : null;
      final size = renderBoxRed?.size;
      final newCardHeight = (size?.height ?? 0) + 80;
      if (cardHeight.value != newCardHeight) {
        cardHeight.value = newCardHeight;
      }
    }

    return Column(
      children: [
        GestureDetector(
          onLongPress: () => onShareCard(context, cardKey),
          child: SizedBox(
            width: double.infinity,
            height: cardHeight.value ?? 184,
            child: RepaintBoundary(
              key: cardKey,
              child: Container(
                decoration: BoxDecoration(
                  color: role == UserRole.worker ? _workerShareBackgroundColor : _userShareBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    bottomLeft: Radius.circular(32.0),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          key: qrKey,
                          margin: const EdgeInsets.only(left: 32),
                          width: getQrCodeContainerWidth(constraints),
                          child: Builder(builder: (context) {
                            WidgetsBinding.instance.addPostFrameCallback((_) => onLayout());
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  LocaleKeys.ShareCardText1.tr(),
                                  style: textStyle,
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: payload != null
                                          ? QrImageView(
                                              size: getQrCodeSize(constraints),
                                              padding: const EdgeInsets.all(8),
                                              data: payload!,
                                            )
                                          : SizedBox(
                                              width: getQrCodeSize(constraints),
                                              height: getQrCodeSize(constraints),
                                            ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.ShareCardText2.tr(),
                                              style: textStyle,
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text(
                                              LocaleKeys.ShareCardText3.tr(),
                                              style: textStyle,
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text(
                                              '···',
                                              style: textStyle,
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 16,
                        child: Assets.images.imageWomanShare.image(
                          width: constraints.maxWidth * 0.5,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Assets.images.iconAppLauncher.image(
                                height: shareButtonHeight,
                              ),
                            ),
                            Container(width: 8),
                            SizedBox(
                              width: 160,
                              child: FilledButton(
                                style: Theme.of(context).filledButtonTheme.style?.copyWith(
                                      minimumSize: const Size.fromHeight(24).asMSP,
                                      backgroundColor: Theme.of(context).colorScheme.background.asMSP,
                                      foregroundColor: Theme.of(context).colorScheme.onBackground.asMSP,
                                    ),
                                onPressed: onShareClicked,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.Share.tr(),
                                        style: shareTextStyle,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: ClipOval(
                                          child: Container(
                                            color: Theme.of(context).primaryColor,
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (disclaimerWidget != null) ...[
          disclaimerWidget,
        ]
      ],
    );
  }

  Widget? buildDisclaimer(BuildContext context) {
    /// Refer and gift them %.0f %@ discount when they create the first order over  %.0f %@.
    /// You will receive %.0f %@ credits too!
    /// And, we will donate %.0f %@ to WWF foundation.

    final country = this.country;
    if (country == null) return null;

    final arg1 = _ReferralBonus.referral1(country);
    if (arg1 == null) return null;

    final arg2 = _ReferralBonus.referral2(country);
    if (arg2 == null) return null;

    final arg3 = _ReferralBonus.referral3(country);
    if (arg3 == null) return null;

    final arg4 = _ReferralBonus.referral4(country);
    if (arg4 == null) return null;

    final text = role == UserRole.user ? LocaleKeys.ShareDisclamer : LocaleKeys.ShareDisclamerDriver;
    final args = <String, String>{};

    if (role == UserRole.user) {
      args['#1'] = arg1.$1.format(arg1.$2);
      args['#2'] = '';
      args['#3'] = arg2.$1.format(arg2.$2);
      args['#4'] = '';
      args['#5'] = arg3.$1.format(arg3.$2);
      args['#6'] = '';
      args['#7'] = arg4.$1.format(arg4.$2);
      args['#8'] = '';
    } else {
      args['#1'] = arg2.$1.format(arg2.$2);
      args['#2'] = '';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text.tr(namedArgs: args),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Future<void> onShareCard(
    BuildContext context,
    GlobalKey cardKey, [
    final int attempt = 0,
  ]) async {
    try {
      if (kIsWeb) {
        return;
      }

      final obj = cardKey.currentContext?.findRenderObject();
      if (obj == null || obj is RenderRepaintBoundary) {
        return;
      }

      RenderRepaintBoundary boundary = obj as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/mooov_share.png';
      final imageFile = File(path);

      if (pngBytes == null) {
        return;
      }

      await imageFile.writeAsBytes(pngBytes, flush: true);
      await Share.shareXFiles([XFile(path)]);
      onImageShareClicked();
    } catch (e) {
      if (attempt < 3) {
        Future.delayed(const Duration(milliseconds: 50)).then(
          (value) => onShareCard(
            context,
            cardKey,
            attempt + 1,
          ),
        );
      }
    }
  }
}

abstract class _ReferralBonus {
  static const referral1Map = {
    'SEK': 50.0,
    'NOK': 50.0,
    'DKK': 50.0,
    'EUR': 5.0,
  };

  static const referral2Map = {
    'SEK': 100.0,
    'NOK': 50.0,
    'DKK': 50.0,
    'EUR': 10.0,
  };

  static const referral3Map = {
    'SEK': 20.0,
    'NOK': 50.0,
    'DKK': 50.0,
    'EUR': 2.0,
  };

  static const referral4Map = {
    'SEK': 20.0,
    'NOK': 50.0,
    'DKK': 50.0,
    'EUR': 2.0,
  };

  /// Amount that you will give to the referred
  static (Currency, Money)? referral1(Country country) {
    final currency = country.toCurrency();
    final currencyCode = currency.code.toUpperCase();
    final value = referral1Map[currencyCode.toUpperCase()];
    if (value == null) {
      return null;
    }

    return (currency, value);
  }

  /// Order amount to get the referred bonus
  static (Currency, Money)? referral2(Country country) {
    final currency = country.toCurrency();
    final currencyCode = currency.code.toUpperCase();
    final value = referral2Map[currencyCode.toUpperCase()];
    if (value == null) {
      return null;
    }

    return (currency, value);
  }

  /// Credit received by referring
  static (Currency, Money)? referral3(Country country) {
    final currency = country.toCurrency();
    final currencyCode = currency.code.toUpperCase();
    final value = referral3Map[currencyCode.toUpperCase()];
    if (value == null) {
      return null;
    }

    return (currency, value);
  }

  /// Amount given to WWF
  static (Currency, Money)? referral4(Country country) {
    final currency = country.toCurrency();
    final currencyCode = currency.code.toUpperCase();
    final value = referral4Map[currencyCode];
    if (value == null) {
      return null;
    }

    return (currency, value);
  }
}

extension on Country {
  Currency toCurrency() {
    switch (this) {
      case Country.SE:
        return Currency.SEK;
      case Country.NO:
        return Currency.NOK;
      case Country.DK:
        return Currency.DKK;
      default:
        return Currency.EUR;
    }
  }
}
