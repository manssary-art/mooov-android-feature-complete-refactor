import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class ProfileIceBanner extends StatelessWidget {
  const ProfileIceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 32),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: [
              Assets.images.imageIceBackground.image(
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    LocaleKeys.ProfileSlogan.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
