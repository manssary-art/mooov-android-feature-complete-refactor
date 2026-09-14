part of 'profile_user_info_header.dart';

class _ProfileUserMedals extends StatelessWidget {
  const _ProfileUserMedals({super.key});

  @override
  Widget build(BuildContext context) {
    const medalSize = 24.0;
    const bulletSpacing = 4.0;
    final bullet = Bullet(size: 2, color: Theme.of(context).disabledColor);
    final style = Theme.of(context).textTheme.bodySmall;
    const spacing = SizedBox(width: bulletSpacing);
    final bullets = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [bullet, spacing, bullet, spacing, bullet],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth / 4;
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bullets,
                  bullets,
                  bullets,
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      Assets.images.iconMedalBlue.image(
                        width: medalSize,
                        height: medalSize,
                      ),
                      Text(
                        LocaleKeys.Basic.tr(),
                        maxLines: 1,
                        softWrap: false,
                        style: style,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      Assets.images.iconMedalGray.image(
                        width: medalSize,
                        height: medalSize,
                      ),
                      Text(
                        LocaleKeys.Silver.tr(),
                        maxLines: 1,
                        softWrap: false,
                        style: style,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      Assets.images.iconMedalGray.image(
                        width: medalSize,
                        height: medalSize,
                      ),
                      Text(
                        LocaleKeys.Gold.tr(),
                        maxLines: 1,
                        softWrap: false,
                        style: style,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      Assets.images.iconMedalGray.image(
                        width: medalSize,
                        height: medalSize,
                      ),
                      Text(
                        LocaleKeys.Diamond.tr(),
                        maxLines: 1,
                        softWrap: false,
                        style: style,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

extension on UserLevel {
  Color get color {
    switch (this) {
      case UserLevel.bronze:
        return const Color(0xFFDF9144);
      case UserLevel.silver:
        return const Color(0xFFC2D4D4);
      case UserLevel.gold:
        return const Color(0xFFFFCB1F);
      case UserLevel.platinum:
        return const Color(0xFF847A96);
      default:
        return const Color(0xFFDF9144);
    }
  }

  String get text {
    switch (this) {
      case UserLevel.bronze:
        return "Brozen";
      case UserLevel.silver:
        return "Silver";
      case UserLevel.gold:
        return "Gold";
      case UserLevel.platinum:
        return "Platinum";
      default:
        return "Brozen";
    }
  }
}
