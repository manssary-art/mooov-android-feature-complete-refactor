import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../di/di.dart';
import '../../../hooks/flutter_hooks.dart';
import '../utilities/location_permission_request_route.dart';

bool _locationPermissionRequested = false;

typedef _NavItems = ({AssetGenImage icon, AssetGenImage activeIcon, String label});

class RootScreen extends HookWidget {
  final int? currentIndex;
  final Widget child;
  final ValueChanged<int> onTap;

  const RootScreen({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    index.value = currentIndex ?? index.value;
    final navItems = useMemoized(
      () => <_NavItems>[
        (
          activeIcon: Assets.images.iconTabHomeSelected,
          icon: Assets.images.iconTabHomeUnselected,
          label: LocaleKeys.Home.tr(),
        ),
        (
          activeIcon: Assets.images.iconTabDiscoverSelected,
          icon: Assets.images.iconTabDiscoverUnselected,
          label: LocaleKeys.Discover.tr(),
        ),
        (
          activeIcon: Assets.images.iconTabActivitiesSelected,
          icon: Assets.images.iconTabActivitiesUnselected,
          label: LocaleKeys.Activities.tr(),
        ),
        (
          activeIcon: Assets.images.iconTabProfileSelected,
          icon: Assets.images.iconTabProfileUnselected,
          label: LocaleKeys.Profile.tr(),
        ),
      ],
    );

    final isGranted = useFuture(
      Di.locationService.getLocationPermission(requestPermission: false),
    );

    usePostFrameEffect(() {
      final isGrantedData = isGranted.data;
      if (_locationPermissionRequested || isGrantedData == null || isGrantedData) return null;
      showLocationPermissionRequestBottomModalSheet(context: context);
      _locationPermissionRequested = true;
      return null;
    }, [isGranted.data]);

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNav(
        context: context,
        currentIndex: index.value,
        items: navItems,
        onItemClicked: onTap,
      ),
    );
  }

  static Widget _buildBottomNav({
    required BuildContext context,
    required int currentIndex,
    required List<_NavItems> items,
    required void Function(int index) onItemClicked,
  }) =>
      BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemClicked,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: [
          for (final item in items) ...[
            BottomNavigationBarItem(
              activeIcon: item.activeIcon.image(
                width: 24,
                height: 24,
              ),
              icon: item.icon.image(
                width: 24,
                height: 24,
              ),
              label: item.label,
            ),
          ],
        ],
      );
}
