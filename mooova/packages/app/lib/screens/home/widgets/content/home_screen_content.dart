import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:linkable/linkable.dart';

import '../../../../../models/types/order_type.dart';
import '../home_image_card.dart';

class HomeScreenContent extends StatelessWidget {
  final String? userLocation;
  final String? info;
  final void Function(OrderType) onPlaceOrderClicked;
  final void Function() onHowItWorksClicked;
  final void Function() onWhatCanDoClicked;

  const HomeScreenContent({
    super.key,
    required this.userLocation,
    required this.info,
    required this.onPlaceOrderClicked,
    required this.onHowItWorksClicked,
    required this.onWhatCanDoClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildHeadline(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildUpperArea(context),
              ),
              _buildBullets(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildBottomArea(context),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildHeadline(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.imageMooova.image(
            fit: BoxFit.cover,
            height: 60,
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.BoookIn2Minutes.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
        ],
      );

  Widget _buildPlaceOrderCards(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              LocaleKeys.WhatDoYouNeedHelp.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFB9B9B9),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
          ),
          HomeImageCard(
            image: Assets.images.imageHomeCardMove,
            text: LocaleKeys.Move.tr(),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            onClicked: () => onPlaceOrderClicked(OrderType.move),
          ),
          HomeImageCard(
            image: Assets.images.imageHomeCardRecycle,
            text: LocaleKeys.Recycle.tr(),
            textColor: Colors.white,
            onClicked: () => onPlaceOrderClicked(OrderType.recycle),
          ),
          Row(
            children: [
              Expanded(
                child: HomeImageCard(
                  wide: false,
                  image: Assets.images.imageHomeCardBuyForMe,
                  text: LocaleKeys.BuyForMe.tr(),
                  textColor: Colors.white,
                  onClicked: () => onPlaceOrderClicked(OrderType.buyForMe),
                ),
              ),
              Expanded(
                child: HomeImageCard(
                  wide: false,
                  image: Assets.images.imageHomeCardGiveAway,
                  text: LocaleKeys.GiveAway.tr(),
                  textColor: Colors.black,
                  onClicked: () => onPlaceOrderClicked(OrderType.giveAway),
                ),
              )
            ],
          ),
        ],
      );

  Widget _buildUpperArea(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          if (userLocation != null) ...[
            Row(
              children: [
                Assets.images.iconMapMarker.image(
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(userLocation!),
              ],
            ),
            const SizedBox(height: 8),
          ],
          _buildPlaceOrderCards(context),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Divider(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              LocaleKeys.HowDoesItWork1.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFB9B9B9),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: onHowItWorksClicked,
              child: Row(
                children: [
                  Assets.images.iconHandHoldingPhone.image(
                    width: 40,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      LocaleKeys.HowDoesItWork2.tr(),
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildBottomArea(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              LocaleKeys.HomeLocalCollaborations.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFB9B9B9),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Assets.images.imageHomeYellowCard.image(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.HomeStockholmStandMission.tr(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Assets.images.imageStadsmissionLogo.image(
                      width: 120,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Divider(),
            ),
          ),
          Clickable(
            onTap: onWhatCanDoClicked,
            child: Stack(
              children: [
                Assets.images.imageHomeCardPark.image(
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  top: 16,
                  left: 16,
                  right: 120,
                  child: Text(
                    LocaleKeys.SomeServicesMight.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (info != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                LocaleKeys.SomeServicesMight.tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFFB9B9B9),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
            ),
            Stack(
              children: [
                Assets.images.imageHomeCardInfo.image(),
                Positioned.fill(
                  top: 16,
                  left: 16,
                  right: 120,
                  child: Linkable(
                    text: info!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ],
      );

  Widget _buildBullets(
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDD069),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.imageHomeItemCheck.image(
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Builder(
                      builder: (context) {
                        final start = DateTime(2023, 05, 07);
                        final now = DateTime.now();
                        final acc = start.difference(now).inDays.abs();
                        return Text(
                          '${18850 + (acc)}+',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    Text(
                      LocaleKeys.HomeAssignments.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDD069),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.imageHomeItemHappyFace.image(
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '100%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      LocaleKeys.HomeSatisfaction.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDD069),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.imageHomeItemCo2.image(
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '67 tons ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      LocaleKeys.HomeCO2.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
